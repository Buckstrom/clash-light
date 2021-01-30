isHovering = (point_in_rectangle(mouse_x, mouse_y, mAPPEAR_COORDS))
if (isHovering) {
	if (mouse_check_button_pressed(mb_left)) {
		var _e = 0;
		repeat (ds_list_size(mBATTLE.reg_enemy)) {
			instance_destroy(mBATTLE.reg_enemy[| _e++]);
		}
		ds_list_clear(mBATTLE.reg_enemy);
	}
}