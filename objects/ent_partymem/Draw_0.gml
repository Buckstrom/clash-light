draw_set_color(c_white)
var _trackColor = mWEP.trackColors[? choiceTrack];
var _useSprites = global.use_sprites
draw_set_font(fnt_blocks)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
var _highlighted = isHovering || (mBATTLE.current_partymem = reg_space);
switch (_highlighted) {
	case true:
	draw_rectangle(mAPPEAR_COORDS, false)
	var _textColor = _trackColor
	var _outlineColor = c_black
	break;
	case false:
	draw_rectangle_width(mAPPEAR_COORDS, 2)
	var _textColor = _trackColor
	var _outlineColor = c_black
	break;
}
//draw action
if (choiceWep != -1 && choiceTrack != -1) {
	switch (_useSprites) {
		case false:
		var _text = string_upper(string_copy(choiceTrack, 0, 3)) + string(choiceWep + 1)
		draw_text_outlined(x, y, _text, _outlineColor, _textColor)
		break;
		case true:
		var _assetName = "spr_" + choiceTrack + "_ttcc"
		var _spriteAsset = asset_get_index(_assetName)
		var _validSprite = false;
		var _spriteScale = 1
		if (_spriteAsset > -1) {
			if (sprite_get_number(_spriteAsset) > choiceWep) {
				_validSprite = true;
				var _spriteSize = sprite_get_height(_spriteAsset);
				draw_sprite_outlined_ext(_spriteAsset, choiceWep, x, y, (appear_height / _spriteSize) * _spriteScale, (appear_height / _spriteSize) * _spriteScale, 0, c_white, 1, 2)
			}
		}
		if (!_validSprite) {
			var _text = string_upper(string_copy(choiceTrack, 0, 3)) + string(choiceWep + 1)
			draw_text_outlined(x, y, _text, _outlineColor, _textColor)
		}
		break;
	}
}
else if (nextAction != false) {
	draw_text_outlined(x, y, string_upper(string_copy(nextAction, 0, 4)))
}
draw_set_color(c_white)
draw_set_valign(fa_top)
//draw hp
draw_text_ext(x, y + (appear_height / 2), given_name + "\n" + string(currentHP) + " / " + string(maxHP), font_get_size(fnt_blocks) * 1.5, view_wport[0])
//draw target
if (choiceTarget != -1) {
	draw_set_valign(fa_bottom)
	draw_set_halign(fa_right)
	draw_set_font(fnt_mini)
	draw_text_outlined(x + (appear_width / 2), y - (appear_height / 2) + 3, notate_target(choiceTarget, check_for_prestige(self, choiceTrack)));
}
//draw damage
if (choiceWep != -1) {
	var _wepDetails = mWEP.wTracks[? choiceTrack]
	draw_set_valign(fa_bottom)
	draw_set_halign(fa_left)
	draw_set_font(fnt_blocks)
	draw_text_outlined(x - (appear_width / 2), y - (appear_height / 2) + 3, "-" + string(_wepDetails[# choiceWep, 1]), c_black, c_red);
}
//draw swap indicators
if (mBATTLE.current_partymem = reg_space && mBATTLE.currentState != battleState.p_target) {
	draw_set_halign(fa_right)
	draw_set_valign(fa_middle)
	draw_set_font(fnt_blocks)
	draw_set_color(c_white)
	draw_text_outlined(x - (appear_width / 2), y, "<- \nA ");
	draw_set_halign(fa_left)
	draw_text_outlined(x + (appear_width / 2), y, " ->\n D");
}