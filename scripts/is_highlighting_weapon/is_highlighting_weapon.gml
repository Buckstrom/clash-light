// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function is_highlighting_weapon(){
	return (hovering_column > -1 &&
			hovering_column < row_length &&
			hovering_row > -1 &&
			hovering_row < row_amount);
}
function is_highlighting_misc(){
	var _actionAmt = ds_list_size(viewing_mem.miscInv)
	var _hoveringAction = row_amount - hovering_row
	return (hovering_misc &&
			hovering_row > (row_amount - (_actionAmt + 1)) &&
			hovering_row < row_amount);
}