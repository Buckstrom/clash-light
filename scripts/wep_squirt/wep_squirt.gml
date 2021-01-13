// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_squirt(attack){
	useLureKB = true;
	damage_target(attack, comboBase);
	switch (check_for_prestige(attack.attacker, attack.trackname)) {
		default:
		debuff_target(attack, "soaked", 1, 0, 0)
		break;
		//Lv 1 Prestige: Soak adjacent enemies (if possible)
		case 1:
		for (var i = attack.target - 1; i <= attack.target + 1; ++i) {
			var _soakTarget = mBATTLE.reg_enemy[| i];
			if (!is_undefined(_soakTarget)) {
				debuff_single(i, "soaked", 2, 0, 0)
			}
		}
		break;
	}
}