// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function decrement_debuffs(target){
	var _enemy = mBATTLE.reg_enemy[| target]
	var _seekDebuff = ds_map_find_first(_enemy.debuffs)
	for (var i = 0; i < ds_map_size(_enemy.debuffs); ++i) {
		if (_enemy.debuffs[? _seekDebuff][debuff_properties.duration] > 1) {
			_enemy.debuffs[? _seekDebuff][debuff_properties.duration] -= 1;
		}
		else {
			ds_map_delete(_enemy.debuffs, _seekDebuff);
		}
		_seekDebuff = ds_map_find_next(_enemy.debuffs, _seekDebuff)
	} 
}
function decrement_debuffs_row(reg){
	var _e = 0;
	repeat(ds_list_size(mBATTLE.reg_enemy)) {
		if (instance_exists(mBATTLE.reg_enemy[| _e])) {
			decrement_debuffs(_e);
			set_debuff_stacking(_e++, "lured", false, reg)
		}
	}
}