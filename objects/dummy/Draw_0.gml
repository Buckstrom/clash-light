draw_text(0,0,hovering_row)
var i = 0;
repeat (15) {
	var _button = {
		x1 : x + (i * button_width),
		y1 : y + (button_height / 2) + ((button_height)),
		x2 : x + (button_width + (i * button_width)),
		y2 : y + (button_height / 2) + button_height + ((button_height)),
	};
	draw_set_color(c_blue)
	draw_set_alpha(0.5)
	draw_roundrect(mBUTTON_COORDS, false)
	draw_set_alpha(1)
	draw_set_color(c_black)
	draw_roundrect(_button.x1 + 1, _button.y1 + 1, _button.x2 - 1, _button.y2 - 1, true)
	draw_set_color(c_white);
	++i;
}