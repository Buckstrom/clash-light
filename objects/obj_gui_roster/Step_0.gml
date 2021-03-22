/// @description Insert description here

switch ds_exists(roster, ds_type_grid) {
	case true:
	var _nameAmt = ds_grid_width(roster)
	var _hoverSpaceRaw = (mouse_y - (y - (1 + (margin / 2)) - (margin / 2))) / margin;
	hoverSpace = floor(_hoverSpaceRaw) + scrollPos - 1;
	isHovering = (mouse_x > (x - (button_width / 2)) && mouse_x < (x + button_width / 2)) && hoverSpace > -1 && hoverSpace < (scrollLimit + scrollPos - 1);
	break;
	
	case false:
	//read .clroster file, generate DS map based on data (column = character)
	if (file_exists(rosterFileName)) {
	    roster = load_csv(rosterFileName);
	}
	break;
}