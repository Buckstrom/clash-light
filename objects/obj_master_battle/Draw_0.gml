var _trackCount = ds_map_size(mCURRENT_MEM.ownedtracks)
var _totalTracks = ds_list_size(mWEP.wTracks)
// GUI
draw_set_color(c_purple)
var _enemyBack = {
	x1 : 0,
	y1 : 0,
	x2 : view_wport[0],
	y2 : ((view_hport[0]) * wepgui_margin)  - (_totalTracks * (button_height / 2)) - (button_height / 2) - 1
}
//draw_rectangle(mENEMYBACK_COORDS, false)
switch (currentState) {
	case battleState.intro:
	draw_set_color(c_black)
	draw_rectangle(0, 0, view_wport[0], view_hport[0], false)
	draw_set_color(c_white)
	draw_set_font(useFont)
	draw_set_valign(fa_middle)
	draw_set_halign(fa_center)
	draw_text(view_wport[0] / 2, view_hport[0] / 2, "Begin battle!")
	break;
	case battleState.p_choice:
	//draw weapon GUI background
	var _trackLength = 8;
	var _wepBack = {
		x1 : (view_wport[0]/2) - (_trackLength * (button_width / 2)) + 1,
		y1 : wepgui_offset_y + ((view_hport[0]) * wepgui_margin)  - (_totalTracks * (button_height / 2)) - (button_height / 2) + 1,
		x2 : (view_wport[0]/2) - (_trackLength * (button_width / 2)) + (button_width + ((_trackLength - 1) * button_width)) - 1,
		y2 : wepgui_offset_y + ((view_hport[0]) * wepgui_margin)  - (_totalTracks * (button_height / 2)) + (button_height / 2) + (((_totalTracks - 1) * button_height)) - 1,
	};
	draw_set_color(c_white)
	draw_rectangle(mWEPBACK_COORDS, true)
	for (var t = 0; t < _totalTracks; ++t) {
		//execute for each track that the member owns
		var _readTrack = mWEP.trackNames[| t]
		_trackLength = ds_grid_width(mWEP.wTracks[? _readTrack])
		//check if previewing a hovered member
		var _viewingMem;
		if (hovering_partymem != -1 && hovering_partymem != current_partymem) {
			_viewingMem = mHOVERING_MEM;
		}
		else {
			_viewingMem = mCURRENT_MEM;
		}
		//change track color
		var _trackColor = mWEP.trackColors[? _readTrack]
		if ds_map_exists(_viewingMem.inventory, _readTrack) {
			//draw track header
			var _trackHeader = {
				x1 : (view_wport[0]/2) - (_trackLength * (button_width / 2)) - (button_width / 2),
				y1 : wepgui_offset_y + ((view_hport[0]) * wepgui_margin)  - (_totalTracks * (button_height / 2)) - (button_height / 2) + ((button_height * t)),
				x2 : (view_wport[0]/2) - (_trackLength * (button_width / 2)) + (button_width + ((_trackLength - 1) * button_width)) - 1 + (button_width / 2),
				y2 : wepgui_offset_y + ((view_hport[0]) * wepgui_margin) - (_totalTracks * (button_height / 2)) + (button_height / 2) + ((button_height * t)),
			}
			//set to track color
			draw_set_color(_trackColor)
			draw_rectangle(_trackHeader.x1, _trackHeader.y1, _trackHeader.x2, _trackHeader.y2, false)
			for (var i = 0; i < ds_grid_width(_viewingMem.inventory[? _readTrack]); ++i){
				//draw each weapon, quantity, and availability
				var _button = {
					x1 : (view_wport[0]/2) - (_trackLength * (button_width / 2)) + (i * button_width),
					y1 : wepgui_offset_y + ((view_hport[0]) * wepgui_margin)  - (_totalTracks * (button_height / 2)) - (button_height / 2) + ((button_height * t)),
					x2 : (view_wport[0]/2) - (_trackLength * (button_width / 2)) + (button_width + (i * button_width)),
					y2 : wepgui_offset_y + ((view_hport[0]) * wepgui_margin) - (_totalTracks * (button_height / 2)) + (button_height / 2) + ((button_height * t)),
				};
				//prepare to draw button
				draw_set_alpha(1)
				draw_set_color(c_white)
				draw_set_valign(fa_middle)
				draw_set_halign(fa_center)
				//check for mouse hover
				if (point_in_rectangle(mouse_x, mouse_y, mBUTTON_COORDS)) {
					//modify button look
					draw_roundrect(mBUTTON_COORDS, false)
					draw_set_color(c_black)
					draw_set_font(useFont)
					draw_text(mBUTTON_CENTER, string_upper(string_copy(_readTrack, 0, 3)) + string(i + 1))
					//change current hover weapon
					if (currentWep != i || currentTrack != _readTrack) {
						currentWep = i;
						currentTrack = _readTrack;
						wepString = ds_grid_get(mWEP.wTracks[? currentTrack], currentWep, 0);
					}
					hoveringWep = true;
				}
				//draw normal button
				else {
					draw_set_color(c_blue)
					draw_set_alpha(0.5)
					draw_roundrect(mBUTTON_COORDS, false)
					draw_set_alpha(1)
					draw_set_color(c_black)
					draw_roundrect(_button.x1 + 1, _button.y1 + 1, _button.x2 - 1, _button.y2 - 1, true)
					draw_set_color(c_white)
					draw_set_font(useFont)
					draw_text(mBUTTON_CENTER, string_upper(string_copy(_readTrack, 0, 3)) + string(i + 1))
				}
				//var _weapon = ds_grid_get(mWEP.wTracks[? _readTrack], i, 0);
				if (!debug_ignoreQuantities) {
					draw_set_halign(fa_right)
					draw_set_font(fnt_mini)
					draw_text(_button.x2, _button.y2 - (font_get_size(fnt_mini) / 2), ds_grid_get(_viewingMem.inventory[? _readTrack], i, 0));
				}
			}
		}
	}
	if (!hoveringWep) {
		currentWep = -1;
		currentTrack = -1;
		wepString = "";
	}
	hoveringWep = false;
	break;
	case battleState.p_target:
	draw_set_color(c_white)
	draw_set_font(useFont)
	draw_text(view_wport[0] / 2, view_hport[0] / 2, "Choose A Target\nPress M2 to Cancel")
	break;
	case battleState.p_attack:
	draw_set_color(c_white)
	draw_set_font(useFont)
	draw_set_valign(fa_middle)
	draw_text(view_wport[0] / 2, view_hport[0] / 2, "Attack phase; M1 to Jump To Next")
	break;
	case battleState.e_attack:
	draw_set_color(c_white)
	draw_set_font(useFont)
	draw_text(view_wport[0] / 2, view_hport[0] / 2, "Enemy attacks; not coded yet. Press M1 to Continue")
	break;
}
// debug
draw_set_valign(fa_top)
draw_set_halign(fa_left)
draw_set_color(c_white)
draw_set_font(useFont)
draw_text(0,0,string(currentState) + "\n" + mCURRENT_MEM.given_name + "\n" + wepString);
