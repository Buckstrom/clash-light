// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_eatk(attack){
	switch (attack.spec) {
		default:
		break;
		//change damage depending on specialty / exe
		case specialty_types.atk:
		attack.damage = ceil(1.2 * attack.damage)
		break;
		case specialty_types.def:
		attack.damage = ceil(0.8 * attack.damage)
		break;
	}
	if (attack.attacker.isExe) {
		attack.damage = ceil(1.5 * attack.damage)
	}
	damage_target(attack, 1)
}