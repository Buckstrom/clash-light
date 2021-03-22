/// @description Insert description here
var _trackAmt = ds_map_size(mWEP.trackNames);
draw_set_font(useFont);
draw_set_valign(fa_bottom);
draw_set_halign(fa_center);
switch ds_exists(roster, ds_type_grid) {
	case true:
	draw_text_outlined(x, y, "Roster:", c_black, c_white)
	var _rosterSize = ds_grid_width(roster);
	var _limit = min(scrollLimit + scrollPos,_rosterSize)
	draw_set_valign(fa_top);
	for (var i = scrollPos; i < _limit; ++i) {
		var _button = {
			x1 : floor(x - (button_width / 2)),
			y1 : floor(y + ((button_height * i))),
			x2 : floor(x + (button_width / 2)),
			y2 : floor(y + (button_height) + ((button_height * i))),
		};
		draw_set_color(c_white);
		switch (hoverSpace == i && isHovering) {
			case true:
			draw_rectangle(mBUTTON_COORDS, false)
			break;
			case false:
			draw_rectangle_width(mBUTTON_COORDS, 2)
			break;
		}
		var _charName = roster[# i, clchar_properties.name];
		draw_text_outlined(x, y + (margin * (i)), _charName, c_black, c_white)
		for (var t = 0; t < _trackAmt; ++t) {
			
		}
	}
	draw_text(x, y+(margin * (i+1)), string(hoverSpace));
	break;
	case false:
	draw_text_outlined(x, y, "No Roster Found", c_black, c_white)
	break;
}