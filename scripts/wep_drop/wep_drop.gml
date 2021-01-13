// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_drop(attack){
	var _enemy = ds_list_find_value(mBATTLE.reg_enemy, attack.target)
	//Cannot damage lured enemies
	if (ds_map_exists(_enemy.debuffs, "lured")) {
		return;
	}
	comboScaled += 0.15
	damage_target(attack, comboScaled)
}