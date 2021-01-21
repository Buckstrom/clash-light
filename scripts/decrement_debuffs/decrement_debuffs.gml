// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function decrement_debuffs(enemy){
	for (var i = 0; i < ds_list_size(mWEP.debuffNames); ++i) {
		var _seekDebuff = mWEP.debuffNames[| i]
		if (ds_map_exists(enemy.debuffs, _seekDebuff)) {
			if (enemy.debuffs[? _seekDebuff][debuff_properties.duration] > 1) {
				--enemy.debuffs[? _seekDebuff][debuff_properties.duration];
			}
			else {
				ds_map_delete(enemy.debuffs, _seekDebuff);
			}
		}
	}
}
function decrement_debuffs_row(){
	for (var i = 0; i < ds_list_size(mBATTLE.reg_enemy); ++i) {
		decrement_debuffs(mBATTLE.reg_enemy[| i]);
	}
}
function reset_damage_display_row(){
	for (var i = 0; i < ds_list_size(mBATTLE.reg_enemy); ++i) {
		ds_list_clear(mBATTLE.reg_enemy[| i].damageValuesIn);
		ds_list_clear(mBATTLE.reg_enemy[| i].damageColorsIn);
	}
}