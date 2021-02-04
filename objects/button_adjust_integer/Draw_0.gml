draw_set_color(c_white)
switch (isHoveringUp) {
	case true:
	draw_rectangle(mUP_COORDS, false)
	break;
	case false:
	draw_rectangle(mUP_COORDS, true)
	break;
}
switch (isHoveringDown) {
	case true:
	draw_rectangle(mDOWN_COORDS, false)
	break;
	case false:
	draw_rectangle(mDOWN_COORDS, true)
	break;
}
draw_set_font(fnt_blocks)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_text_outlined(x,y + 2,string(editValue))
draw_set_valign(fa_top)
draw_text_outlined(x,y + (appear_height * 2.5),label);