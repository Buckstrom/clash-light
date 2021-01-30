isHoveringUp = (point_in_rectangle(mouse_x, mouse_y, mUP_COORDS))
if (isHoveringUp) {
	if (mouse_check_button_pressed(mb_left)) {
		++editValue;
	}
}
isHoveringDown = (point_in_rectangle(mouse_x, mouse_y, mDOWN_COORDS))
if (isHoveringDown) {
	if (mouse_check_button_pressed(mb_left)) {
		--editValue;
	}
}