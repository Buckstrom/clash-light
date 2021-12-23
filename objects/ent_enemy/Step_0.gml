isHovering = (point_in_rectangle(mouse_x, mouse_y, mAPPEAR_COORDS))
if (isHovering) {
	mBATTLE.hovering_enemy = reg_space
	//input custom enemy params
	if (debug_enterType && keyboard_check(vk_lshift) && mouse_check_button_pressed(mb_left)) {
		debug_textEntryActive = true;
		//instance_deactivate_all(true)
		keyboard_string = "";
	}
}
if (debug_textEntryActive) {
	if (keyboard_check_pressed(vk_enter) && string_length(keyboard_string) > 0) {
		var _readLevel = string_digits(keyboard_string);
		if (_readLevel != "") {
			level = real(_readLevel);
		}
		isExe = (string_pos("x", string_lower(keyboard_string)) != 0);
		var _checkAtk = (string_pos("a", string_lower(keyboard_string)))
		var _checkDef = (string_pos("d", string_lower(keyboard_string)))
		if (_checkDef == 0 && _checkAtk == 0) {
			specialty = specialty_types.none
		}
		else {
			if (_checkDef > _checkAtk) {
				specialty = specialty_types.def
			}
			if (_checkDef < _checkAtk) {
				specialty = specialty_types.atk
			}
		}
		set_enemy_hp(self, true);
		if keyboard_string = "LIT" {
			given_name = "Litigator"
			level = 40
			sprite_index = gator
			set_enemy_hp(self, true, 4250)
		}
		refresh_row(mBATTLE.reg_enemy, entity_type.enemy)
		debug_textEntryActive = false;
		//instance_activate_all();
	}
	if (keyboard_check_pressed(vk_escape) || mBATTLE.currentState != battleState.p_choice) {
		debug_textEntryActive = false;
		//instance_activate_all();
	}
}