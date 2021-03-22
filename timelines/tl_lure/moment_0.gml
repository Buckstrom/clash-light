switch(activeAttack.target) {
	default:
	var _useAnim = fx_ray;
	break;
	case -2:
	var _useAnim = fx_waveIn;
	break;
}

anim_fx(_useAnim, activeAttack.attacker, targetRow[| activeAttack.target], c_white, attackAnimTime)
