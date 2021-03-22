var _currentState = mBATTLE.currentState
var _currentMem = mBATTLE.current_partymem
isHovering = (point_in_rectangle(mouse_x, mouse_y, mAPPEAR_COORDS))
if (isHovering && _currentState = battleState.p_choice) {
	if (_currentMem != reg_space) {
		mBATTLE.hovering_partymem = reg_space
		if (mouse_check_button_pressed(mb_left)) {
			mBATTLE.current_partymem = reg_space;
		}
	}
}