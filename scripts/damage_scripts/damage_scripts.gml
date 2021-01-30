// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function damage_target(attack,combofactor){
	switch(attack.target) {
		default:
		damage_single(attack,combofactor)
		break;
		case -2:
		damage_all(attack,combofactor)
		break;
	}
}
function debuff_target(attack, debuffname, duration, factor, misc, stacks){
	switch(attack.target) {
		default:
		debuff_single(attack.target, debuffname, duration, factor, misc, stacks)
		break;
		case -2:
		debuff_all(debuffname, duration, factor, misc, stacks)
		break;
	}
}
function damage_single(attack, combofactor){
	var _enemy = ds_list_find_value(mBATTLE.reg_enemy, attack.target)
	if (is_undefined(_enemy)) {
		return;
	}
	_enemy.comboMultiplier = combofactor;
	takeDamage(_enemy, attack.damage);
	++_enemy.comboCount;
}
function damage_all(attack, combofactor){
	var _row = ds_list_size(mBATTLE.reg_enemy);
	for (var i = 0; i < _row; ++i) {
		var _enemy = mBATTLE.reg_enemy[| i]
		_enemy.comboMultiplier = combofactor;
		takeDamage(_enemy, attack.damage);
		++_enemy.comboCount;
	}
}
function debuff_single(target, debuffname, duration, factor, misc, stacks){
	if (is_undefined(stacks)) {
		stacks = false;
	}
	var _properties = array_debuff_properties(duration, factor, misc, stacks)
	var _enemy = ds_list_find_value(mBATTLE.reg_enemy, target)
	if (is_undefined(_enemy)) {
		return;
	}
	if (!ds_map_exists(_enemy.debuffs, debuffname)) {
		ds_map_add(_enemy.debuffs, debuffname, _properties)
		checkTrap(_enemy);
	}
	//stack debuffs if allowed
	else if (_enemy.debuffs[? debuffname][debuff_properties.stacks]) {
		//add to duration
		_enemy.debuffs[? debuffname][debuff_properties.duration] += duration;
		//keep higher factor
		if (factor > _enemy.debuffs[? debuffname][debuff_properties.factor]) {
			_enemy.debuffs[? debuffname][debuff_properties.factor] = factor;
		}
	}
}
function debuff_all(debuffname, duration, factor, misc, stacks){
	var _e = 0;
	repeat (ds_list_size(mBATTLE.reg_enemy)) {
		debuff_single(_e++, debuffname, duration, factor, misc, stacks);
	}
}
function array_debuff_properties(duration, factor, misc, stacks) {
	var _properties = array_create(4)
	_properties[debuff_properties.duration] = duration
	_properties[debuff_properties.factor] = factor
	_properties[debuff_properties.misc] = misc;
	_properties[debuff_properties.stacks] = stacks;
	return _properties;
}
function takeDamage(enemy, damage) {
	enemy.currentHP -= damage;
	enemy.damageSum += damage;
	ds_list_set(enemy.damageValuesIn, damageOrder, damage);
	ds_list_set(enemy.damageColorsIn, damageOrder, c_red);
}
function checkTrap(enemy) {
	//check for being lured into trap
	if (!ds_map_exists(enemy.debuffs, "unlured") && ds_map_exists(enemy.debuffs, "lured") && ds_queue_size(enemy.trapQueue) > 0) {
		var _activeTrap = ds_queue_dequeue(enemy.trapQueue)
		takeDamage(enemy, _activeTrap.damage);
		ds_map_delete(enemy.debuffs, "lured")
		debuff_single(enemy, "unlured", 0, 0, 0)
	}
}
function resetCombo(enemy) {
	enemy.damageSum = 0;
	enemy.comboMultiplier = 0;
	enemy.comboCount = 0;
}
function calcCombo() {
	var _trackChange = false;
	switch (ds_priority_size(attackQueue)) {
		case 0:
		_trackChange = true;
		break;
		default:
		_trackChange = activeAttack.trackname != ds_priority_find_min(attackQueue).trackname;
		break
	}
	if (_trackChange) {
		var _comboDamage = false;
		var _knockbackDamage = false;
		for (var i = 0; i < ds_list_size(mBATTLE.reg_enemy); ++i) {
			var _enemy = mBATTLE.reg_enemy[| i]
			//clear double traps
			if (ds_queue_size(_enemy.trapQueue) > 1) {
				ds_queue_clear(_enemy.trapQueue);
			}
			//deal combo damage
			if (_enemy.comboCount > 1 && useCombo) {
				_comboDamage = ceil((_enemy.damageSum) * comboScaled[i])
				_enemy.currentHP -= _comboDamage
				var _offset = 1;
				ds_list_set(_enemy.damageValuesIn, damageOrder + _offset, _comboDamage);
				ds_list_set(_enemy.damageColorsIn, damageOrder + _offset, c_yellow);
			}
			//deal lure damage; unlures after taking damage regardless of bonus
			if (ds_map_exists(_enemy.debuffs, "lured") && _enemy.damageSum > 0) {
				if (useLureKB) {
					var _lureFactor = array_get(ds_map_find_value(_enemy.debuffs, "lured"), debuff_properties.factor);
					_knockbackDamage = ceil((_enemy.damageSum) * _lureFactor)
					_enemy.currentHP -= _knockbackDamage;
					var _offset = 1;
					if (_comboDamage) {
						++_offset
					}
					ds_list_set(_enemy.damageValuesIn, damageOrder + _offset, _knockbackDamage);
					ds_list_set(_enemy.damageColorsIn, damageOrder + _offset, c_orange);
				}
				ds_map_delete(_enemy.debuffs, "lured")
			}
			//reset per-track damage intake
			resetCombo(_enemy);
			comboScaled[i] = comboBase;
			//prepare enemy clear sequence if dead
			if (!(_enemy.currentHP > 0) && !mBATTLE.clearDead) {
				mBATTLE.clearDead = true;
			}
		}
		if (_comboDamage) {
			++damageOrder;
		}
		if (_knockbackDamage) {
			++damageOrder;
		}
	}
}
function set_debuff_stacking(target,debuffname,stacks) {
	var _enemy = mBATTLE.reg_enemy[| target];
	if (ds_map_exists(_enemy.debuffs, debuffname)) {
		_enemy.debuffs[? debuffname][debuff_properties.stacks] = stacks;
	}
}