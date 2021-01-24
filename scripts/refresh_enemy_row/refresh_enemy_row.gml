// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function refresh_enemy_row(){
	for (var i = 0; i < ds_list_size(mBATTLE.reg_enemy); ++i) {
			mBATTLE.reg_enemy[| i].reg_space = i;
			mBATTLE.reg_enemy[| i].x = view_wport[0] * ((2 + i) / (3 + ds_list_size(mBATTLE.reg_enemy)))
	}
}
function remove_dead_enemy_row(){
	var _oldEnemyRow = ds_list_size(mBATTLE.reg_enemy);
	var _newEnemyRow = _oldEnemyRow;
	for (var i = 0; i < _oldEnemyRow;) {
		//check if enemy exists
		var _clearEnemy = is_undefined(mBATTLE.reg_enemy[| i])
		//check enemy if their HP has depleted; destroy enemy if true
		if (!_clearEnemy) {
			if !(mBATTLE.reg_enemy[| i].currentHP > 0) {
				instance_destroy(mBATTLE.reg_enemy[| i]);
				_clearEnemy = true;
			}
		}
		switch (_clearEnemy) {
			case true:
			ds_list_delete(mBATTLE.reg_enemy, i);
			--_newEnemyRow
			break;
			case false:
			//check next enemy in the row
			++i
			break;
		}
		//if checking beyond range, end loop
		if (i = _newEnemyRow) {
			break;
		}
	}
}
function clear_damage_display_row(){
	for (var i = 0; i < ds_list_size(mBATTLE.reg_enemy); ++i) {
		ds_list_clear(mBATTLE.reg_enemy[| i].damageValuesIn);
		ds_list_clear(mBATTLE.reg_enemy[| i].damageColorsIn);
	}
}