// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_throw(attack){
	useLureKB = true;
	useCombo = true;
	switch (check_for_prestige(attack.attacker, attack.trackname)) {
		default:
		break;
		//Lv 1 Prestige: 15% damage bonus
		case 1:
		attack.damage = ceil(1.15 * attack.damage)
		break;
	}
	damage_target(attack, comboBase)
}