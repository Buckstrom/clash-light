// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_trap(attack){
	var _enemy = targetRow[| attack.target]
	var _healthyThreshold = .5
	var _isHealthy = (_enemy.currentHP / _enemy.maxHP) > 0.5
	var _isExe = _enemy.isExe
	//Base: 30% damage bonus to Executive enemies
	if (_isExe) attack.damage = ceil(attack.damage * 1.3)
	switch (check_for_prestige(attack.attacker, attack.trackname)) {
		default:
		break;
		//Prestige: 20% damage bonus to healthy enemies
		case 1:
		if (_isHealthy) attack.damage = ceil(attack.damage * 1.2)
		break;
		//Legacy Prestige: Enemy level * 3 damage bonus
		case 2:
		attack.damage = ceil(attack.damage + (_enemy.level * 3))
		break;
	}
	if (!ds_map_exists(_enemy.debuffs, "lured")) {
		ds_queue_enqueue(_enemy.trapQueue, attack)
	}
}