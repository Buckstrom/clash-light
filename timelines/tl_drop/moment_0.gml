switch (activeAttack.target) {
	case -2:
	var _e = 0;
	repeat (ds_list_size(mBATTLE.reg_enemy)) {
		anim_fx(fx_waveIn, mBATTLE.reg_enemy[| _e++], 0, c_maroon, attackAnimTime)
	}
	break;
	default:
	anim_fx(fx_waveIn, mBATTLE.reg_enemy[| activeAttack.target], 0, c_maroon, attackAnimTime)
	break;
}