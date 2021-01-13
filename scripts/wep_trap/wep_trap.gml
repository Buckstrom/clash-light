// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_trap(attack){
	var _enemy = mBATTLE.reg_enemy[| attack.target]
	ds_queue_enqueue(_enemy.trapQueue, attack)
}