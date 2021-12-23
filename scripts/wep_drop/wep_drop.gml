// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_drop(attack){
	useCombo = true;
	var _wep = function(_attack,_target){
		_attack.target = _target;
		var _enemy = ds_list_find_value(targetRow, _target)
		//Cannot damage lured enemies
		if (ds_map_exists(_enemy.debuffs, "lured")) {
			return;
		}
		//Add to combo multiplier
		if (_enemy.comboCount > 1) {
			comboScaled[_target] += 0.10;
		}
		//Prestige benefits
		switch (check_for_prestige(_attack.attacker, _attack.trackname)) {
			default:
			break;
			//Lv 1 Prestige: +10% combo damage scaling (accuracy can wait :-) )
			case 1:
			comboScaled[_target] += 0.10;
			break;
		}
		damage_target(_attack, comboScaled[_target])
	}
	switch (attack.target) {
		case -2:
		var _e = 0;
		repeat (ds_list_size(targetRow)) {
			_wep(attack,_e);
			++_e;
		}
		break;
		default:
		var _e = attack.target;
		_wep(attack,_e);
		break;
	}
}