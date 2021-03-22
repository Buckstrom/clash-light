// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_trap(attack){
	var _enemy = targetRow[| attack.target]
	switch (check_for_prestige(attack.attacker, attack.trackname)) {
		default:
		break;
		//Lv 1 Prestige: Enemy level * 3 damage bonus
		case 1:
		attack.damage = ceil(attack.damage + (_enemy.level * 3))
		break;
	}
	if (!ds_map_exists(_enemy.debuffs, "lured")) {
		ds_queue_enqueue(_enemy.trapQueue, attack)
	}
}