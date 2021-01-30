draw_set_color(c_white)
switch (editValue) {
	case true:
	draw_rectangle(mAPPEAR_COORDS, false)
	break;
	case false:
	draw_rectangle(mAPPEAR_COORDS, true)
	break;
}
draw_set_font(fnt_blocks)
draw_set_halign(fa_left)
draw_set_valign(fa_middle)
draw_text(x + (appear_height / 2) + font_get_size(fnt_blocks),y,label)