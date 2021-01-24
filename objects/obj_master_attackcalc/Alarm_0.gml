
/// @description Perform next attack
//if all attacks are finished resolving, transition to enemy attack and decrement debuffs
if !(ds_priority_size(attackQueue) > 0) {
	mBATTLE.currentState = battleState.e_attack
	decrement_debuffs_row();
	instance_destroy(self);
}
else {
	timeline_running = false;
	activeAttack = ds_priority_delete_min(attackQueue)
	if (timeline_exists(mWEP.trackTimelines[? activeAttack.trackname])) {
		timeline_index = mWEP.trackTimelines[? activeAttack.trackname];
		timeline_position = 0;
		timeline_running = true;
		timeline_speed = 1 / attackAnimTime;
	}
	++attackNum
}
//perform attack
//script_execute(mWEP.trackScripts[? activeAttack.trackname], activeAttack, attackAnimTime);
//remove intent from partymem
//clear_target(activeAttack.attacker);