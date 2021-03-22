switch (activeAttack.target) {
	case -2:
	var _e = 0;
	repeat (ds_list_size(targetRow)) {
		anim_fx(fx_waveIn, targetRow[| _e++], 0, c_maroon, attackAnimTime)
	}
	break;
	default:
	anim_fx(fx_waveIn, targetRow[| activeAttack.target], 0, c_maroon, attackAnimTime)
	break;
}