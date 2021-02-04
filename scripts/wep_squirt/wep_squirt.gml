// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_squirt(attack){
	useLureKB = true;
	useCombo = true;
	//calc direct attack
	damage_target(attack, comboBase);
	//prestige check
	switch (check_for_prestige(attack.attacker, attack.trackname)) {
		default:
		debuff_target(attack, "soaked", attack.factor, 0, 0)
		break;
		//Lv 1 Prestige: Soak adjacent enemies (if possible)
		case 1:
		for (var i = attack.target - 1; i <= attack.target + 1; ++i) {
			var _soakTarget = mBATTLE.reg_enemy[| i];
			if (!is_undefined(_soakTarget)) {
				debuff_single(i, "soaked", attack.factor + 1, 0, 0)
			}
		}
		break;
	}
}