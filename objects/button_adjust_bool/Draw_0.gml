draw_set_color(c_white)
switch (isHovering){
	case true:
	draw_rectangle(mAPPEAR_COORDS, false)
	break;
	case false:
	draw_rectangle(mAPPEAR_COORDS, true)
	break;
}
switch (editValue) {
	case true:
	draw_sprite_outlined(ico_check, 0, mAPPEAR_CENTER, 1)
	break;
	case false:
	draw_sprite_outlined(ico_cross, 0, mAPPEAR_CENTER, 1)
	break;
}
draw_set_font(fnt_blocks)
draw_set_halign(fa_left)
draw_set_valign(fa_middle)
draw_text_outlined(x + (appear_height / 2) + font_get_size(fnt_blocks),y,label)