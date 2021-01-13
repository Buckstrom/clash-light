// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function notate_target(targetID){
	var _output = ""
	for (i = 0; i < ds_list_size(mBATTLE.reg_enemy); ++i) {
		if (i = targetID || targetID == -2) {
			_output += "X"
		}
		else {
			_output += "-"
		}
	}
	return _output;
}