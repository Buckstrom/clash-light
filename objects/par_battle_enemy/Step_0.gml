isHovering = (point_in_rectangle(mouse_x, mouse_y, mAPPEAR_COORDS))
if (isHovering) {
	mBATTLE.hovering_enemy = reg_space
	if (debug_enterType && keyboard_check(vk_lshift) && mouse_check_button_pressed(mb_left)) {
		debug_textEntryActive = true;
		//instance_deactivate_all(true)
		keyboard_string = "";
	}
}
if (debug_textEntryActive) {
	if (keyboard_check_pressed(vk_enter)) {
		level = real(string_digits(keyboard_string));
		isExe = (string_pos("x", string_lower(keyboard_string)) != 0);
		var _checkAtk = (string_pos("a", string_lower(keyboard_string)))
		var _checkDef = (string_pos("d", string_lower(keyboard_string)))
		if (_checkDef > _checkAtk) {
			specialty = specialty_types.def
		}
		if (_checkDef < _checkAtk) {
			specialty = specialty_types.atk
		}
		if (_checkDef == 0 && _checkAtk = 0) {
			specialty = specialty_types.none
		}
		set_enemy_hp(self, true);
		refresh_enemy_row()
		debug_textEntryActive = false;
		//instance_activate_all();
	}
	if (keyboard_check_pressed(vk_escape)) {
		debug_textEntryActive = false;
		//instance_activate_all();
	}
}