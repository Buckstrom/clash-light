var _active = false;
var _useSprites = global.use_sprites
if !instance_exists(viewing_mem) return;
for (var t = 0; t < row_amount; ++t) {
	var _readTrack = mWEP.trackNames[| t]
	//set track header
	var _trackHeader = {
		x1 : x - (row_length * (button_width / 2)) - (button_width / 2),
		y1 : y - (row_amount * (button_height / 2)) - (button_height / 2) + ((button_height * t)),
		x2 : x - (row_length * (button_width / 2)) + (button_width + ((row_length - 1) * button_width)) - 1 + (button_width / 2),
		y2 : y - (row_amount * (button_height / 2)) + (button_height / 2) + ((button_height * t)) - 1,
	}
	//set button slots (wepback)
	var _wepBack = {
		x1 : x - ((row_amount + 1) * (button_width / 2)) + 1,
		y1 : y - (row_amount * (button_height / 2)) - (button_height / 2) + ((button_height * t)),
		x2 : x - ((row_amount + 1) * (button_width / 2)) + (button_width + ((row_amount) * button_width)) - 1,
		y2 : y - (row_amount * (button_height / 2)) + (button_height / 2) + ((button_height * t)) - 1,
	};
	//draw buttons
	var _trackExists = ds_map_exists(viewing_mem.inventory, _readTrack);
	if (_trackExists) {
		//set to track color
		var _trackColor = mWEP.trackColors[? _readTrack]
		draw_set_color(_trackColor)
		//draw header
		draw_roundrect(_trackHeader.x1, _trackHeader.y1, _trackHeader.x2, _trackHeader.y2, false)
		//draw wepback
		draw_set_color(c_dkgray)
		draw_set_alpha(0.5)
		draw_roundrect(mWEPBACK_COORDS, false)
		//set button color
		var _buttonColor = merge_color(c_blue, _trackColor, 0.5)
		var _trackLength = ds_grid_width(viewing_mem.inventory[? _readTrack])
		switch (check_for_prestige(viewing_mem, _readTrack)) {
			case true:
			var _presButton = 1;
			break;
			case false:
			var _presButton = 0;
			break
		}
		for (var i = 0; i < _trackLength; ++i){
			//draw each weapon, quantity, and availability
			var _button = {
				x1 : x - (row_length * (button_width / 2)) + (i * button_width),
				y1 : floor(y  - (row_amount * (button_height / 2)) - (button_height / 2) + ((button_height * t))),
				x2 : x - (row_length * (button_width / 2)) + (button_width + (i * button_width)),
				y2 : floor(y - (row_amount * (button_height / 2)) + (button_height / 2) + ((button_height * t))),
			};
			//prepare to draw button
			draw_set_alpha(1)
			draw_set_color(c_white)
			draw_set_valign(fa_middle)
			draw_set_halign(fa_center)
			var _textColor = c_white;
			var _textOutline = c_black;
			//check for mouse hover
			if (i == hovering_column && t == hovering_row) {
				var _active = true;
				var _activeTrack = _readTrack;
				var _activeButton = _button;
				var _activePres = _presButton;
				var _activeColor = _trackColor
			}
			//draw normal button
			else {
				draw_set_color(_buttonColor)
				//draw_set_alpha(0.5)
				//draw_roundrect(mBUTTON_COORDS, false)
				//draw_set_alpha(1)
				//draw_set_color(c_black)
				//draw_roundrect(_button.x1 + 1, _button.y1 + 1, _button.x2 - 1, _button.y2 - 1, true)
				if /*(t == hovering_row || i == hovering_column) || */!is_highlighting_weapon() {
					var _buttonAlpha = 1
					var _buttonTint = c_white
				}
				else {
					var _buttonAlpha = 1
					//var _buttonAlpha = 0.5
					var _buttonTint = c_white
				}
				draw_sprite_ext(spr_button_wep, _presButton, mBUTTON_CENTER, 1,1, 0, _buttonTint, _buttonAlpha)
				var _buttonScale = 1;
				//var _text = string(i + 1)
				switch (_useSprites) {
					case false:
					//if (/*(i == hovering_column || t == hovering_row) &&*/
					//is_highlighting_weapon()) {
						var _text = /*string_upper(string_copy(_readTrack, 0, 3)) + */"Lv. " + string(i + 1)
						draw_text_outlined(mBUTTON_CENTER, _text, _textOutline, _textColor)
					//}
					/*else {
						var _text = string(i + 1)
					}
					draw_set_font(fnt_blocks)
					draw_text_outlined(mBUTTON_CENTER, _textOutline, _textColor, _text)*/
					break;
			
					case true:
					var _assetName = "spr_" + _readTrack + "_ttcc"
					var _spriteAsset = asset_get_index(_assetName)
					var _validSprite = false;
					if (_spriteAsset > -1) {
						if (sprite_get_number(_spriteAsset) > i) {
							_validSprite = true;
							var _spriteSize = sprite_get_height(_spriteAsset);
							draw_sprite_outlined_ext(_spriteAsset, i, mBUTTON_CENTER, (button_height / _spriteSize) * _buttonScale, (button_height / _spriteSize) * _buttonScale, 0, c_white, 1, 1)
						}
					}
					if (!_validSprite) {
						var _text = /*string_upper(string_copy(_readTrack, 0, 3)) + */"Lv. " + string(i + 1)
						draw_text_outlined(mBUTTON_CENTER, _text, _textOutline, _textColor)
					}
					break;
				}
			}
			//var _weapon = ds_grid_get(mWEP.wTracks[? _readTrack], i, 0);
			if (!debug_ignoreQuantities) {
				draw_set_halign(fa_right)
				draw_set_font(fnt_mini)
				draw_text(_button.x2, _button.y2 - (font_get_size(fnt_mini) / 2), ds_grid_get(viewing_mem.inventory[? _readTrack], i, 0));
			}
		}
	}
		//draw empty track
		else {
			//set to track color (darkened)
			var _trackColor = merge_color(mWEP.trackColors[? _readTrack], c_dkgray, 0.5)
			draw_set_color(_trackColor)
			//draw header
			draw_roundrect(_trackHeader.x1, _trackHeader.y1, _trackHeader.x2, _trackHeader.y2, false)
			//draw wepback
			draw_set_alpha(0.5)
			draw_set_color(c_dkgray)
			draw_roundrect(mWEPBACK_COORDS, false)
			draw_set_alpha(1)
		}
	//draw prestige toggle button
	var _pres = {
		x1 : 4 + (x - (row_length * (button_width / 2)) + (row_length * button_width)),
		y1 : 4 + (y  - (row_amount * (button_height / 2)) - (button_height / 2) + ((button_height * t))),
		x2 : -4 + (x - (row_length * (button_width / 2)) + ((button_width / 2) + (row_length * button_width))),
		y2 : -4 + (y - (row_amount * (button_height / 2)) + (button_height / 2) + ((button_height * t)))
	};
	draw_set_color(c_black)
	draw_roundrect(mPRES_COORDS, !viewing_mem.invPres[? _readTrack]);
	if (viewing_mem.invPres[? _readTrack]) {
		draw_sprite_ext(ico_pres, 0, mPRES_CENTER, 1, 1, 0, c_white, 1)
	}
	else {
		draw_sprite_ext(ico_pres, 0, mPRES_CENTER, 1, 1, 0, c_black, 1);
	}
	//draw track toggle button
	var _pres = {
		x1 : -4 + (x - (button_width / 2) - (button_width * (row_length / 2))),
		y1 : -4 + (y  - (row_amount * (button_height / 2)) - (button_height / 2) + ((button_height * t))),
		x2 : 4 + (x - (button_width * (row_length / 2))),
		y2 : 4 + (y - (row_amount * (button_height / 2)) + (button_height / 2) + ((button_height * t)))
	};
	//draw_set_color(c_black)
	//draw_roundrect(mPRES_COORDS, ds_map_exists(viewing_mem.inventory, _readTrack));
	if (ds_map_exists(viewing_mem.inventory, _readTrack)) {
		draw_sprite_outlined(ico_check, 0, mPRES_CENTER, 1)
	}
	else {
		draw_sprite_outlined(ico_cross, 0, mPRES_CENTER, 1)
	}
}
//draw misc action
if (debug_modifyTracks) {
	var _actions = viewing_mem.miscInv;
	for (var i = 0; i < ds_list_size(_actions); ++i){
		//draw from the bottom
		var m = row_amount - (i + 1);
		//draw each weapon, quantity, and availability
		var _button = {
			x1 : x - (row_length * (button_width / 2)) + ((row_length + 0.5) * button_width),
			y1 : floor(y - (row_amount * (button_height / 2)) - (button_height / 2) + ((button_height * m))),
			x2 : x - (row_length * (button_width / 2)) + (button_width + ((row_length + 0.5) * button_width)),
			y2 : floor(y - (row_amount * (button_height / 2)) + (button_height / 2) + ((button_height * m))),
		};
		//prepare to draw button
		draw_set_alpha(1)
		draw_set_color(c_white)
		draw_set_valign(fa_middle)
		draw_set_halign(fa_center)
		//check for mouse hover
		if (hovering_row == m && hovering_misc) {
			//modify button look
			draw_sprite_ext(spr_button_wep,2, mBUTTON_CENTER, 1,1, 0, c_white, 1)
			var _textColor = c_black
			var _textOutline = c_white
		}
		//draw normal button
		else {
			var _buttonAlpha = 1
			var _buttonTint = c_white
			draw_sprite_ext(spr_button_wep, 0, mBUTTON_CENTER, 1,1, 0, _buttonTint, _buttonAlpha)
			var _textColor = c_white;
			var _textOutline = c_black;
		}
		switch (_useSprites) {
			case false:
			//if (/*(i == hovering_column || t == hovering_row) &&*/
			//is_highlighting_weapon()) {
				var _text = _actions[| i]
				draw_text_outlined(mBUTTON_CENTER, _text, _textOutline, _textColor)
			//}
			/*else {
				var _text = string(i + 1)
			}
			draw_set_font(fnt_blocks)
			draw_text_outlined(mBUTTON_CENTER, _textOutline, _textColor, _text)*/
			break;
			
			case true:
			var _text = _actions[| i]
			draw_text_outlined(mBUTTON_CENTER, _text, _textOutline, _textColor)
			break;
		}
	}
}
//draw track descriptor
if (_active) {
	var _descBackDown = {
		x1 : x - (row_length * (button_width / 2)) - (button_width / 2),
		y1 : y + ((row_amount + 2) * (button_height / 2)) - (button_height / 2) + ((button_height * -1)) + 1,
		x2 : x - (row_length * (button_width / 2)) + (button_width + ((row_length - 1) * button_width)) - 1 + (button_width / 2),
		y2 : y + ((row_amount + 2) * (button_height / 2)) + (button_height / 2) + ((button_height * -1)),
	}
	var _descBack = {
		x1 : x - (row_length * (button_width / 2)) - (button_width / 2),
		y1 : y - (row_amount * (button_height / 2)) - (button_height / 2) + ((button_height * -1)) + 1,
		x2 : x - (row_length * (button_width / 2)) + (button_width + ((row_length - 1) * button_width)) - 1 + (button_width / 2),
		y2 : y - (row_amount * (button_height / 2)) + (button_height / 2) + ((button_height * -1)),
	}
	if (viewing_mem.invPres[? _activeTrack]) {
		_text = "Prestige "
	}
	else {
		_text = "";
	}
	_text += string_ucfirst(_activeTrack) + " Level " + string(hovering_column + 1);
	var _overPanelWidth = font_get_size(fnt_blocks) * 20
	draw_set_alpha(1);
	draw_set_color(_activeColor)
	draw_rectangle(mHEADER_CENTER_X - (_overPanelWidth / 3), _descBackDown.y1 + 2, mHEADER_CENTER_X + (_overPanelWidth / 3), _descBackDown.y1 + 4, false);
	_textColor = c_white;
	_textOutline = c_black;
	draw_text_outlined(mHEADER_CENTER_X, mean(_descBackDown.y1,_descBackDown.y2), _text, _textOutline, _textColor)
	//draw top header
	draw_set_alpha(0.5)
	draw_set_color(_activeColor)
	draw_roundrect(_descBack.x1,_descBack.y1,_descBack.x2,_descBack.y2, false);
	//draw active button in front (before desc text)
	_buttonScale = 4/3;
	draw_sprite_ext(spr_button_wep, _activePres + 2, mACTIVE_CENTER, _buttonScale, _buttonScale, 0, _activeColor, 1)
	var _textColor = c_black
	var _textOutline = _activeColor
	switch (_useSprites) {
		case false:
		var _text = "Lv. " + string(hovering_column + 1)
		draw_text_outlined(mACTIVE_CENTER, _text, _textOutline, _textColor)
		break;
		case true:
		var _assetName = "spr_" + hovering_trackName + "_ttcc"
		var _spriteAsset = asset_get_index(_assetName)
		var _validSprite = false;
		if (_spriteAsset > -1) {
			if (sprite_get_number(_spriteAsset) > hovering_column) {
				_validSprite = true;
				var _spriteSize = sprite_get_height(_spriteAsset);
				draw_sprite_outlined_ext(_spriteAsset, hovering_column, mACTIVE_CENTER, (button_height / _spriteSize) * (_buttonScale * 2), (button_height / _spriteSize) * (_buttonScale * 2), 0, c_white, 1, _spriteSize / button_height)
			}
		}
		if (!_validSprite) {
			var _text = "Lv. " + string(hovering_column + 1)
			draw_text_outlined(mACTIVE_CENTER, _text, _textOutline, _textColor)
		}
		break;
	}
	//draw wep details
	draw_set_alpha(1)
	var _textColor = c_white
	var _textOutline = c_black
	var _wepDetails = mWEP.wTracks[? _activeTrack]
	var _wepPrestige = check_for_prestige(viewing_mem, _activeTrack)
	var _wepText = _wepDetails[# hovering_column, 0] +
	" | "
	var _wepDamage = real(_wepDetails[# hovering_column, 1])
	if (_activeTrack == "zap") {
		_wepText += display_zap_factor(viewing_mem, _wepDamage);
	}
	else {
		_wepText += string(_wepDamage);
	}
	_wepText += display_wep_bonus(_activeTrack, _wepDamage, _wepPrestige, mBATTLE.reg_enemy)
	switch (_activeTrack) {
		case "lure":
		_wepText += " Turns"
		break;
		default:
		_wepText += " Damage"
		break;
		case "squirt":
		var _wepSoak = real(_wepDetails[# hovering_column, 5]);
		_wepText += " Damage | ";
		_wepText += display_squirt_soak(viewing_mem, _wepSoak)
		break;
	}
	switch (_wepDetails[# hovering_column, wep_properties.target]) {
		case 1:
		_wepText += " | Affects All"
		break;
		default:
		_wepText += " | Affects One"
		break;
	}
	draw_set_color(_activeColor)
	draw_text_outlined(mHEADER_CENTER_X, mean(_descBack.y1,_descBack.y2), _wepText, _textOutline, _textColor)
}
//draw all prestige toggle button
var _pres = {
	x1 : 4 + (x - (row_length * (button_width / 2)) + (row_length * button_width)),
	y1 : 4 + (y  - (row_amount * (button_height / 2)) - (button_height / 2) + ((button_height * row_amount))),
	x2 : -4 + (x - (row_length * (button_width / 2)) + ((button_width / 2) + (row_length * button_width))),
	y2 : -4 + (y - (row_amount * (button_height / 2)) + (button_height / 2) + ((button_height * row_amount)))
};
draw_set_color(c_white)
var _i = 0;
var _anyPres = false;
repeat (row_amount) {
	if (_anyPres = viewing_mem.invPres[? mWEP.trackNames[| _i++]]) {
		_anyPres = true;
		break;
	}
}
draw_roundrect(mPRES_COORDS, _anyPres);
if (_anyPres) {
	draw_sprite_ext(ico_pres, 0, mPRES_CENTER, 1, 1, 0, c_white, 1)
}
else {
	draw_sprite_ext(ico_pres, 0, mPRES_CENTER, 1, 1, 0, c_black, 1);
}
//draw all track toggle button
var _pres = {
	x1 : -4 + (x - (button_width / 2) - (button_width * (row_length / 2))),
	y1 : -4 + (y  - (row_amount * (button_height / 2)) - (button_height / 2) + ((button_height * row_amount))),
	x2 : 4 + (x - (button_width * (row_length / 2))),
	y2 : 4 + (y - (row_amount * (button_height / 2)) + (button_height / 2) + ((button_height * row_amount)))
};
var _i = 0;
var _anyTrack = false;
repeat (row_amount) {
	if (_anyTrack = !ds_map_exists(viewing_mem.inventory, mWEP.trackNames[| _i++])) {
		_anyTrack = true;
		break;
	}
}
if (_anyTrack) {
	draw_sprite_outlined(ico_check, 0, mPRES_CENTER, 1)
}
else {
	draw_sprite_outlined(ico_cross, 0, mPRES_CENTER, 1)
}