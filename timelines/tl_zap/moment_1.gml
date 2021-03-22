var _jumpFrom = targetRow[| activeAttack.target];
wep_zap_base(activeAttack);
if (ds_queue_empty(jumpQueue)) {
	calcCombo();
	alarm[0] += attackAnimTime;
	timeline_running = false;
}
else {
	anim_fx(fx_beam, _jumpFrom, targetRow[| ds_queue_head(jumpQueue).target], c_yellow, attackAnimTime)
}