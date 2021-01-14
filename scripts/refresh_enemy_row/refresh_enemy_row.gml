// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function refresh_enemy_row(){
	for (var i = 0; i < ds_list_size(mBATTLE.reg_enemy); ++i) {
			mBATTLE.reg_enemy[| i].x = view_wport[0] * ((2 + i) / (3 + ds_list_size(mBATTLE.reg_enemy)))
	}
}