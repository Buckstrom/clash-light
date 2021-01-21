// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_lure(attack){
	switch (check_for_prestige(attack.attacker, attack.trackname)) {
		default:
		var _kbScaled = 0.5;
		break;
		//Lv 1 Prestige: 65% KB scaling (up from 50%)
		case 1:
		var _kbScaled = 0.65;
		break;
	}
	debuff_target(attack, "lured", attack.damage, _kbScaled, 0);
}