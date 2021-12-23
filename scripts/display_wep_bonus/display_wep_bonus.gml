// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function display_wep_bonus(track, damage, prestige, reg){
	var _bonusBase = "";
	var _bonusPres = "";
	var _rowsize = ds_list_size(reg);
	var _enemyLevelLow = infinity;
	var _enemyLevelHigh = 0;
	var _e = 0;
	repeat (_rowsize) {
		var _checkLevel = reg[| _e++].level;
		if (_enemyLevelLow > _checkLevel) {
			_enemyLevelLow = _checkLevel
		}
		if (_enemyLevelHigh < _checkLevel) {
			_enemyLevelHigh = _checkLevel
		}
	}
	//Trap healthy bonus
	switch (track) {
		default:
		break;
		case "trap":
		var _trapBonus = ceil(damage * 1.3)
		_bonusBase = "/" + string(damage * 1.2);
		break;
	}
	if (prestige) {
		switch (track) {
			default:
			break;
			case "sound":
			_bonusPres = "+" + string(ceil(_enemyLevelHigh * 0.5));
			break;
			case "trap":
			_bonusPres = string(_trapBonus) + "/" + string(ceil(_trapBonus * 1.2));
			break;
			case "drop":
			_bonusPres = "+5% Combo Dmg"
			break;
		}
		if (_bonusPres != "") {
			_bonusPres = "(" + string(_bonusPres) + ")";
		}
	}
	var _output = _bonusBase + _bonusPres;
	return _output;
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
		_output += string(ceil(damage * (_base - (_falloff * _i++))))
		if (_i < _amount) {
			_output += " + "
		}
	}
	return _output;
}
function display_squirt_soak(mem, soakturns) {
	var _output = string(soakturns);
	var _pres = check_for_prestige(mem, "squirt")
	if _pres {
		_output += "(+1)"
	}
	_output += " Rounds"
	return _output;
}