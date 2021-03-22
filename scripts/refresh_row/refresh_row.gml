// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function refresh_row(reg, type){
	for (var i = 0; i < ds_list_size(reg); ++i) {
		var _entity = reg[| i]
		if (_entity > -1) {
			align_entity(_entity, i, reg, type)
			_entity.reg_space = i;
			_entity.turnHP = _entity.prevHP
			_entity.prevHP = _entity.currentHP;
		}
	}
}
function align_entity(entity, space, reg, type) {
	var _x;
	var _y;
	switch (type) {
		case entity_type.enemy:
		_x = view_wport[0] * ((1.5 + space) / (2 + ds_list_size(reg)))
		_y = 92;
		break;
		case entity_type.party:
		_x = view_wport[0] * ((2 + space) / (3 + ds_list_size(reg)));
		_y = view_hport[0] - 64;
		break;
	}
	entity.x = _x;
	entity.y = _y;
}
function remove_dead_row(reg){
	var _oldRow = ds_list_size(reg);
	var _newRow = _oldRow;
	for (var i = 0; i < _oldRow;) {
		//check if enemy exists
		var _entity = reg[| i]
		var _clear = is_undefined(_entity)
		//check enemy if their HP has depleted; destroy enemy if true
		if (!_clear) {
			if !(_entity.currentHP > 0) {
				instance_destroy(_entity);
				_clear = true;
			}
		}
		switch (_clear) {
			case true:
			ds_list_delete(reg, i);
			--_newRow
			break;
			case false:
			//check next enemy in the row
			++i
			break;
		}
		//if checking beyond range, end loop
		if (i = _newRow) {
			break;
		}
	}
}
function clear_damage_display_row(reg){
	for (var i = 0; i < ds_list_size(reg); ++i) {
		var _entity = reg[| i]
		ds_list_clear(_entity.damageValuesIn);
		ds_list_clear(_entity.damageColorsIn);
	}
}