isHovering = (point_in_rectangle(mouse_x, mouse_y, mAPPEAR_COORDS))
if (isHovering && mBATTLE.currentState = battleState.p_choice) {
	if (mBATTLE.current_partymem != reg_space) {
		mBATTLE.hovering_partymem = reg_space
		if (mouse_check_button_pressed(mb_left)) {
			mBATTLE.current_partymem = reg_space;
		}
	}
}