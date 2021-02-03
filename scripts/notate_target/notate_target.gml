// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function notate_target(targetID, pres){
	var _output = ""
	var _row = ds_list_size(mBATTLE.reg_enemy)
	switch (pres) {
		case false:
		var _char = "X";
		break;
		case true:
		var _char = "O";
		break;
	}
	for (i = 0; i < _row; ++i) {
		if (i = targetID || targetID == -2) {
			_output += _char
		}
		else {
			_output += "-"
		}
	}
	return _output;
}