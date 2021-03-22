// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_sound(attack){
	useLureKB = false;
	useCombo = true;
	switch (check_for_prestige(attack.attacker, attack.trackname)) {
		default:
		break;
		//Lv 1 Prestige: Highest Level Enemy Level * 0.5 bonus damage
		case 1:
		var _highestLv = 0;
		for (var i = 0; i < ds_list_size(targetRow); ++i) {
			var _checkLv = targetRow[| i].level;
			if (_highestLv < _checkLv) {
				_highestLv = _checkLv;
			}
		}
		attack.damage = ceil((_highestLv * 0.5) + attack.damage)
		break;
	}
	damage_target(attack, comboBase)
}