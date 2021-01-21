// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_squirt(attack, time){
	useLureKB = true;
	useCombo = true;
	//calc direct attack
	damage_target(attack, comboBase);
	//animate direct attack
	alarm[0] += time;
	var _anim = instance_create_layer(0,0,self.layer,anim_beam)
	_anim.beamStart = attack.attacker;
	_anim.beamDest = mBATTLE.reg_enemy[| attack.target]
	_anim.beamColor = c_aqua;
	_anim.beamTime = time / 2;
	_anim.alarm[0] = time / 2;
	_anim.beamHold = time / 2;
	//prestige check
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