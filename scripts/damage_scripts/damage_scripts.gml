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
function debuff_target(attack, debuffname, duration, factor, misc){
	switch(attack.target) {
		default:
		debuff_single(attack.target, debuffname, duration, factor, misc)
		break;
		case -2:
		debuff_all(debuffname, duration, factor, misc)
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
function debuff_single(target, debuffname, duration, factor, misc){
	var _properties = array_debuff_properties(duration, factor, misc)
	var _enemy = ds_list_find_value(mBATTLE.reg_enemy, target)
	if (is_undefined(_enemy)) {
		return;
	}
	if (!ds_map_exists(_enemy.debuffs, debuffname)) {
		ds_map_add(_enemy.debuffs, debuffname, _properties)
		checkTrap(_enemy);
	}
}
function debuff_all(debuffname, duration, factor, misc){
	var _properties = array_debuff_properties(duration, factor, misc)
	var _row = ds_list_size(mBATTLE.reg_enemy);
	for (var i = 0; i < _row; ++i) {
		var _enemy = mBATTLE.reg_enemy[| i]
		if (!ds_map_exists(_enemy.debuffs, debuffname)) {
			ds_map_add(_enemy.debuffs, debuffname, _properties)
			checkTrap(_enemy)
		}
	}
}
function array_debuff_properties(duration, factor, misc) {
	var _properties = array_create(3)
	_properties[debuff_properties.duration] = duration
	_properties[debuff_properties.factor] = factor
	_properties[debuff_properties.misc] = misc;
	return _properties;
}
function takeDamage(enemy, damage) {
	enemy.currentHP -= damage;
	enemy.damageSum += damage;
	ds_list_add(enemy.damageValuesIn, damage);
	ds_list_add(enemy.damageColorsIn, c_red);
}
function checkTrap(enemy) {
	//check for being lured into trap
	if (ds_map_exists(enemy.debuffs, "lured") && ds_queue_size(enemy.trapQueue) > 0) {
		var _activeTrap = ds_queue_dequeue(enemy.trapQueue)
		enemy.currentHP -= _activeTrap.damage;
		ds_map_delete(enemy.debuffs, "lured")
	}
}
function resetCombo(enemy) {
	enemy.damageSum = 0;
	enemy.comboMultiplier = 0;
	enemy.comboCount = 0;
}
