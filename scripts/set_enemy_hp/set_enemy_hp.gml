// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function set_enemy_hp(enemy, fill, newhp){
	var _newMax;
	switch (enemy.specialty) {
		case specialty_types.atk:
		_newMax = ceil(enemy.level * (enemy.level + 1)) + 1;
		break;
		case specialty_types.def:
		_newMax = ceil((enemy.level + 2) * (enemy.level + 3)) - 2;
		break;
		default:
		_newMax = ceil((enemy.level + 1) * (enemy.level + 2));
		break;
	}
	if (enemy.isExe) {
		_newMax = ceil(_newMax * 1.5);
	}
	if (newhp > -1) {
		_newMax = newhp
	}
	if (fill) {
		if (newhp > -1) {
			enemy.currentHP = newhp;
		}
		else {
			enemy.currentHP = _newMax;
		}
	}
	enemy.maxHP = _newMax;
}