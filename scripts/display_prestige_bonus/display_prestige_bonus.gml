// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function display_prestige_bonus(track, damage){
	var _bonus = "";
	var _row = ds_list_size(mBATTLE.reg_enemy);
	var _enemyLevelLow = infinity;
	var _enemyLevelHigh = 0;
	var _e = 0;
	repeat (_row) {
		var _checkLevel = mBATTLE.reg_enemy[| _e++].level;
		if (_enemyLevelLow > _checkLevel) {
			_enemyLevelLow = _checkLevel
		}
		if (_enemyLevelHigh < _checkLevel) {
			_enemyLevelHigh = _checkLevel
		}
	}
	switch (track) {
		default:
		break;
		case "throw":
		_bonus = ceil(damage * 0.15);
		break;
		case "sound":
		_bonus = ceil(_enemyLevelHigh * 0.5);
		break;
		case "trap":
		_bonus = string(ceil(_enemyLevelLow * 3)) + " to " + string(ceil(_enemyLevelHigh * 3));
		break;
		case "drop":
		_bonus = "5% Combo Dmg"
		break;
		case "squirt":
		_bonus = "Soak Adjacent"
		break;
	}
	if (_bonus != "") {
		return "(+" + string(_bonus) + ")";
	}
	return "";
}
function display_zap_factor(mem, damage) {
	var _base = 3;
	var _falloff = 0.75;
	var _amount = 3;
	var _output = "";
	if check_for_prestige(mem, "zap") {
		var _falloff = 0.5;
	}
	var _i = 0;
	repeat (_amount) {
		_output += string(damage * (_base - (_falloff * _i++)))
		if (_i < _amount) {
			_output += " + "
		}
	}
	return _output;
}