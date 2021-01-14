// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_drop(attack){
	var _enemy = ds_list_find_value(mBATTLE.reg_enemy, attack.target)
	//Cannot damage lured enemies
	if (ds_map_exists(_enemy.debuffs, "lured")) {
		return;
	}
	if (_enemy.comboCount > 0) {
		comboScaled[attack.target] += 0.10;
	}
	switch (check_for_prestige(attack.attacker, attack.trackname)) {
		default:
		break;
		//Lv 1 Prestige: +5% combo damage scaling (accuracy can wait :-) )
		case 1:
		if (_enemy.comboCount > 0) {
			comboScaled[attack.target] += 0.05;
		}
		break;
	}
	damage_target(attack, comboScaled[attack.target])
}