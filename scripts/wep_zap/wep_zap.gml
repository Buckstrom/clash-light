// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_zap_base(attack){
	useLureKB = false;
	useCombo = false;
	
	jumpQueue = ds_queue_create();
	ds_queue_clear(jumpQueue);
	
	var _jumpFactor = 3;
	var _jumpSpaces = 2;
	var _jumpFalloff = 0.75;
	var _jumpAmount = 0;
	var _jumpMax = 3;
	var _jumpValid = false;
	var _originTarget = attack.target
	var _currentTarget = attack.target
	var _baseDamage = attack.damage;
	var _enemy = ds_list_find_value(targetRow, attack.target)
	if (is_undefined(_enemy)) {
		return;
	}
	switch (check_for_prestige(attack.attacker, attack.trackname)) {
		default:
		break;
		//Lv 1 Prestige: 50% damage falloff (down from 66%)
		case 1:
		_jumpFalloff = 0.5;
		break;
	}
	//check enemy soak status
	if (ds_map_exists(_enemy.debuffs, "soaked")) {
		//deal Initial Zap Hit damage (no jumped debuff)
		attack.damage = _baseDamage * (_jumpFactor - (_jumpFalloff * _jumpAmount));
		damage_single(attack, 0);
		++_jumpAmount;
		//perform jumps up to maximum amount
		for (var j = _jumpAmount; j < _jumpMax; ++j) {
			var _jumpOutput = undefined;
			//find next jump candidate within range to the left
			for (var i = _currentTarget - 1; i >= _currentTarget - _jumpSpaces; --i) {
				//go to next check if target is out of range, original target, or already jumped
				if (i < 0 || i >= ds_list_size(targetRow) || i = _originTarget) {
					continue;
				}
				//check if soaked and for jumped debuff
				_enemy = ds_list_find_value(targetRow, i)
				if (!(_enemy.currentHP > 0) || !ds_map_exists(_enemy.debuffs, "soaked") || ds_map_exists(_enemy.debuffs, "jumped")) {
					continue;
				}
				//once valid target is found, apply jump falloff and damage target
				else {
					_jumpValid = true;
					break;
				}
			}
			//find next jump candidate within range to the right
			if (!_jumpValid) {
				for (var i = _currentTarget + 1; i <= _currentTarget + _jumpSpaces; ++i) {
					//go to next check if target is out of range, original target, or already jumped
					if (i < 0 || i >= ds_list_size(targetRow) || i = _originTarget) {
						continue;
					}
					//check if alive, soaked and for jumped debuff
					_enemy = ds_list_find_value(targetRow, i)
					if (!(_enemy.currentHP > 0) || !ds_map_exists(_enemy.debuffs, "soaked") || ds_map_exists(_enemy.debuffs, "jumped")) {
						continue;
					}
					//once valid target is found, apply jump falloff and damage target
					else {
						_jumpValid = true;
						break;
					}
				}
			}
			if (_jumpValid) {
				var _outFactor = (_jumpFactor - (_jumpFalloff * _jumpAmount))
				var _outDamage = ceil(_baseDamage * _outFactor);
				var _outTarget = i;
				_jumpOutput = {
					target : _outTarget,
					damage : _outDamage,
					factor : _outFactor,
				}
				
				ds_queue_enqueue(jumpQueue, _jumpOutput);
				//move to next jump
				_currentTarget = i;
				++_jumpAmount;
				_jumpValid = false;
			}
		}
	}
	//deal dry zap damage
	else {
		damage_single(attack, 0);
	}
}
function wep_zap_jump(attack){
	switch ds_queue_head(jumpQueue) {
		case undefined:
		break;
		default:
		var _jump = ds_queue_dequeue(jumpQueue);
		attack.target = _jump.target;
		attack.damage = _jump.damage;
		damage_single(attack, 0);
		debuff_single(attack.target, "jumped", 0, _jump.factor, 0);
		break;
	}
}