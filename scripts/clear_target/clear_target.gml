// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function clear_target(partymem){
	partymem.choiceTarget = -1;
	partymem.choiceTrack = -1;
	partymem.choiceWep = -1;
}
function clear_target_row(){
	for (var i = 0; i < ds_list_size(mBATTLE.reg_party); ++i) {
		var _partymem = mBATTLE.reg_party[| i];
		_partymem.choiceTarget = -1;
		_partymem.choiceTrack = -1;
		_partymem.choiceWep = -1;
	}
}