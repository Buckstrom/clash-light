// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_zap(attack){
	useLureKB = false;
	var _jumpFactor = 3;
	var _jumpSpaces = 2;
	var _jumpFalloff = 0.75;
	var _jumpAmount = 0;
	var _jumpMax = 3;
	var _jumpValid = false;
	var _originTarget = attack.target
	var _currentTarget = attack.target
	var _baseDamage = attack.damage;
	var _enemy = ds_list_find_value(mBATTLE.reg_enemy, attack.target)
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
			//find next jump candidate within range to the left
			for (var i = _currentTarget; i >= _currentTarget - _jumpSpaces; --i) {
				//go to next check if target is out of range, original target, or already jumped
				if (i < 0 || i >= ds_list_size(mBATTLE.reg_enemy) || i = _originTarget) {
					continue;
				}
				//check if soaked and for jumped debuff
				_enemy = ds_list_find_value(mBATTLE.reg_enemy, i)
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
				for (var i = _currentTarget; i <= _currentTarget + _jumpSpaces; ++i) {
					//go to next check if target is out of range, original target, or already jumped
					if (i < 0 || i >= ds_list_size(mBATTLE.reg_enemy) || i = _originTarget) {
						continue;
					}
					//check if alive, soaked and for jumped debuff
					_enemy = ds_list_find_value(mBATTLE.reg_enemy, i)
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
				attack.damage = ceil(_baseDamage * (_jumpFactor - (_jumpFalloff * _jumpAmount)));
				attack.target = i;
				_currentTarget = i;
				damage_single(attack, 0);
				debuff_single(attack.target, "jumped", 0, 0, 0);
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