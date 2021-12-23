/// @description Insert description here

switch ds_exists(roster, ds_type_grid) {
	case true:
	var _nameAmt = ds_grid_width(roster)
	var _hoverSpaceRaw = (mouse_y - (y - (1 + (margin / 2)) - (margin / 2))) / margin;
	hoverSpace = floor(_hoverSpaceRaw) + scrollPos - 1;
	isHovering = (mouse_x > (x - (button_width / 2)) && mouse_x < (x + button_width / 2)) && hoverSpace > -1 && hoverSpace < (scrollLimit + scrollPos);
	break;
	
	case false:
	//read .clroster file, generate DS map based on data (column = character)
	if (file_exists(rosterFileName)) {
	    roster = load_csv(rosterFileName);
	}
	break;
}
//LMB actions
if (mouse_check_button_pressed(mb_left)) {
	//check if clicking a roster character
	if (isHovering) {
		//instantiate roster character and replace registered character
		var _hoverChar = hoverSpace;
		var _currentMem = mBATTLE.current_partymem
		change_party_mem(roster, _hoverChar, _currentMem)
	}
}
if (mouse_wheel_up()) {
	if scrollPos > 0 {
		--scrollPos
	}
}
if (mouse_wheel_down()) {
	if scrollPos < ds_grid_width(roster) - scrollLimit {
		++scrollPos
	}
}