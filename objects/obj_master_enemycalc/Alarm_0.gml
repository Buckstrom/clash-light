/// @description Perform next attack
//if all attacks are finished resolving, transition to finish
if !(ds_priority_size(attackQueue) > 0) {
	mBATTLE.currentState = battleState.e_finish
	//remove instance id and destroy
	mBATTLE.inst_ecalc = -1;
	instance_destroy(self);
}
else {
	timeline_running = false;
	var _prevTrack = activeAttack.trackname
	activeAttack = ds_priority_delete_min(attackQueue)
	//run attack if target is alive or chaining the same track
	var _targetAlive = (_prevTrack == activeAttack.trackname);
	switch (activeAttack.target) {
		case -2:
		var _e = 0;
		repeat (ds_list_size(mBATTLE.reg_party)) {
			if (mBATTLE.reg_party[| _e++].currentHP > 0) {
				_targetAlive = true;
			}
		}
		break;
		default:
		if (mBATTLE.reg_party[| activeAttack.target].currentHP > 0) {
			_targetAlive = true;
		}
		break;
	}
	if (_targetAlive && timeline_exists(mWEP.trackTimelines[? activeAttack.trackname])) {
		timeline_index = tl_eatk;
		timeline_position = 0;
		timeline_running = true;
		timeline_speed = 1 / attackAnimTime;
	}
	else {
		alarm[0] += attackAnimTime;
	}
	++attackNum;
	++damageOrder;
}
//perform attack
//script_execute(mWEP.trackScripts[? activeAttack.trackname], activeAttack, attackAnimTime);
//remove intent from partymem
//clear_target(activeAttack.attacker);