 draw_set_color(c_white)
draw_set_font(fnt_blocks)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
var _highlighted = isHovering || (mBATTLE.current_partymem = reg_space);
switch (_highlighted) {
	case true:
	draw_rectangle(mAPPEAR_COORDS, false)
	draw_set_color(c_black)
	break;
	case false:
	draw_rectangle_width(mAPPEAR_COORDS, 2)
	break;
}
//draw action
if (choiceWep != -1 && choiceTrack != -1) {
	draw_text(x, y, string_upper(string_copy(choiceTrack, 0, 3)) + string(choiceWep + 1))
}
else if (nextAction != false) {
	draw_text(x, y, string_upper(string_copy(nextAction, 0, 4)))
}
draw_set_color(c_white)
draw_set_valign(fa_top)
//draw hp
draw_text_ext(x, y + (appear_height / 2), given_name + "\n" + string(currentHP) + " / " + string(maxHP), font_get_size(fnt_blocks) * 1.5, view_wport[0])
//draw target
if (choiceTarget != -1) {
	draw_set_valign(fa_bottom)
	draw_set_font(fnt_mini)
	draw_text(x, y - (appear_height / 2) + 3, notate_target(choiceTarget, check_for_prestige(self, choiceTrack)));
}
//draw swap indicators
if (mBATTLE.current_partymem = reg_space && mBATTLE.currentState != battleState.p_target) {
	draw_set_halign(fa_right)
	draw_set_valign(fa_middle)
	draw_set_font(fnt_blocks)
	draw_text(x - (appear_width / 2), y, "<- \nA ");
	draw_set_halign(fa_left)
	draw_text(x + (appear_width / 2), y, " ->\n D");
}