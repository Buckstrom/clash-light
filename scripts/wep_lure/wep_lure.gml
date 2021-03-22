// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_lure(attack){
	useLureKB = false;
	switch (check_for_prestige(attack.attacker, attack.trackname)) {
		default:
		var _kbScaled = 0.5;
		break;
		//Lv 1 Prestige: 65% KB scaling (up from 50%)
		case 1:
		var _kbScaled = 0.65;
		break;
	}
	//stack on unlured
	switch (attack.target) {
		default:
		if (!ds_map_exists(targetRow[| attack.target].debuffs, "lured")) {
			debuff_target(attack, "lured", 0, 0, _kbScaled, true);
		}
		break;
		case -2:
		var _e = 0;
		repeat (ds_list_size(targetRow)) {
			if (!ds_map_exists(targetRow[| _e++].debuffs, "lured")) {
				debuff_target(attack, "lured", 0, 0, _kbScaled, true);
			}
		}
		break;
	}
	debuff_target(attack, "lured", attack.damage, _kbScaled, 0);
}