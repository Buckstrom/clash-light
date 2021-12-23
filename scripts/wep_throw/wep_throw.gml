// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_throw(attack){
	useLureKB = true;
	useCombo = true;
	var _markFactor = 1.08
	var _markStack = 0.04
	var _markDuration = 2
	var _enemy = ds_list_find_value(targetRow, attack.target)
	switch (check_for_prestige(attack.attacker, attack.trackname)) {
		default:
		break;
		//Lv 1 Prestige: Apply MfL, 8% base + 4% per additional throw that turn
		case 1:
		//check if already marked
		switch (ds_map_exists(_enemy.debuffs, "marked")) {
			case true:
			if (_enemy.debuffs[? "marked"][debuff_properties.duration] = _markDuration) {
				_enemy.debuffs[? "marked"][debuff_properties.factor] += _markStack
			}
			break;
			case false:
			debuff_target(attack, "marked", _markDuration, _markFactor, 0)
			break;
		}
		break;
		//Legacy Prestige: 15% damage bonus
		case 2:
		attack.damage = ceil(1.15 * attack.damage)
		break;
	}
	damage_target(attack, comboBase)
}