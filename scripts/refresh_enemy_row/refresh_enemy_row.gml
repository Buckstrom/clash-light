// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function refresh_enemy_row(){
	for (var i = 0; i < ds_list_size(mBATTLE.reg_enemy); ++i) {
		var _enemy = mBATTLE.reg_enemy[| i]
		if (_enemy) {
			_enemy.reg_space = i;
			_enemy.x = view_wport[0] * ((1.5 + i) / (2 + ds_list_size(mBATTLE.reg_enemy)))
			_enemy.y = 92;
			_enemy.prevHP = _enemy.currentHP;
		}
	}
}
function remove_dead_enemy_row(){
	var _oldEnemyRow = ds_list_size(mBATTLE.reg_enemy);
	var _newEnemyRow = _oldEnemyRow;
	for (var i = 0; i < _oldEnemyRow;) {
		//check if enemy exists
		var _enemy = mBATTLE.reg_enemy[| i]
		var _clearEnemy = is_undefined(_enemy)
		//check enemy if their HP has depleted; destroy enemy if true
		if (!_clearEnemy) {
			if !(_enemy.currentHP > 0) {
				instance_destroy(_enemy);
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
		var _enemy = mBATTLE.reg_enemy[| i]
		ds_list_clear(_enemy.damageValuesIn);
		ds_list_clear(_enemy.damageColorsIn);
	}
}