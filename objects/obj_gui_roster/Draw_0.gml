/// @description Insert description here
var _trackAmt = ds_map_size(mWEP.trackNames);
draw_set_font(useFont);
draw_set_valign(fa_bottom);
draw_set_halign(fa_center);
switch ds_exists(roster, ds_type_grid) {
	case true:
	draw_text_outlined(x, y, "Roster:", c_black, c_white)
	var _rosterSize = ds_grid_width(roster);
	var _limit = min(scrollLimit + scrollPos,_rosterSize)
	draw_set_valign(fa_top);
	for (var i = 0; i < scrollLimit; ++i) {
		var _button = {
			x1 : floor(x - (button_width / 2)),
			y1 : floor(y + ((button_height * i))),
			x2 : floor(x + (button_width / 2)),
			y2 : floor(y + (button_height) + ((button_height * i))),
		};
		draw_set_color(c_white);
		var _char = i + scrollPos;
		switch (hoverSpace == _char && isHovering) {
			case true:
			draw_rectangle(mBUTTON_COORDS, false)
			break;
			case false:
			draw_rectangle_width(mBUTTON_COORDS, 2)
			break;
		}
		var _charName = roster[# _char, clchar_properties.name];
		draw_text_outlined(x, y + (margin * (i)), _charName, c_black, c_white)
		for (var t = 0; t < _trackAmt; ++t) {
			var _trackName = mWEP.trackNames[| t]
			var _rawLevel = roster[# _char, clchar_properties.wep + t]
			var _wepLevel = real(string_digits(_rawLevel)) - 1;
			var _wepPres = string_count("p",_rawLevel) > 0;
			var _spriteAsset = get_wep_sprite(_trackName);
			if (_wepLevel > -1) {
				if (_spriteAsset > -1) {
				var _spriteSize = sprite_get_height(_spriteAsset);
				var _presLine = c_black;
				var _presTint = c_white;
				if (_wepPres) {
					_presLine = mWEP.trackColors[? _trackName];
					_presTint = c_blue;
				}
				draw_sprite_outlined_ext(_spriteAsset, _wepLevel, (x - (button_width / 2)) + ((button_width / _trackAmt) * (t + 0.5)), y + (button_height * (3/4)) + (button_height * i), (button_height / _spriteSize) / 2, (button_height / _spriteSize)/ 2, 0, _presTint, 1, 1, _presLine)
				}
			}
		}
	}
	draw_text(x, y+(margin * (i+1)), string(hoverSpace));
	break;
	case false:
	draw_text_outlined(x, y, "No Roster Found", c_black, c_white)
	break;
}