//text entry mode
if (debug_textEntryActive) {
	draw_set_valign(fa_middle)
	draw_set_halign(fa_center)
	draw_set_color(c_black)
	draw_set_alpha(0.5)
	draw_rectangle(0,0,view_wport[0],view_hport[0], false);
	draw_set_alpha(1)
	draw_set_font(fnt_blocks)
	draw_set_color(c_white)
	draw_text(x, y, keyboard_string)
}