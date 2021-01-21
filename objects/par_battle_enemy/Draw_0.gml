//dead appearance
if !(currentHP > 0) {
	draw_set_alpha(0.5)
}
draw_set_color(c_white)
/*if (mBATTLE.current_partymem = reg_space) {
	draw_rectangle(mAPPEAR_COORDS, false)
}
else */switch (isHovering) {
	case true:
	draw_rectangle(mAPPEAR_COORDS, false)
	break;
	case false:
	draw_rectangle(mAPPEAR_COORDS, true)
	break;
}
draw_set_font(fnt_blocks)
draw_set_halign(fa_center)
draw_set_valign(fa_bottom)
//draw enemy details below image
var _tagText = "Level " + string(level);
if (isExe) {
	_tagText += ".exe"
}
_tagText += "\n" + string(currentHP) + " / " + string(maxHP);
draw_text_ext(x, y - (appear_height / 2), _tagText, font_get_size(fnt_blocks) * 1.5, view_wport[0])
//draw enemy name
draw_set_valign(fa_top)
draw_text(x, y + (appear_height / 2), given_name)
//draw debuff list in order
var _debuffList = "";
var _debuffAmt = ds_map_size(debuffs);
var _n = 0;
if (!is_undefined(ds_queue_head(trapQueue))) {
	_debuffList += "trap: " + string(ds_queue_head(trapQueue).damage) + "\n";
}
for (var i = 0; i < ds_list_size(mWEP.debuffNames); ++i) {
	if (ds_map_exists(debuffs, mWEP.debuffNames[| i])) {
		_debuffList += mWEP.debuffNames[| i]
		if (mWEP.debuffNames[| i] == "lured") {
			_debuffList += ": " + string(100 * debuffs[? "lured"][debuff_properties.factor]) + "%";
		}
		if (_n++ < _debuffAmt) {
			_debuffList += "\n"
		}
	}
}
draw_set_valign(fa_middle)
draw_set_font(fnt_blocks)
draw_text(x, y, _debuffList);
//draw received damage
var _damageLine = (y + (appear_height / 2)) + (font_get_size(fnt_blocks) * 2.5)
for (var i = 0; i < ds_list_size(damageValuesIn); ++i) {
	draw_set_color(damageColorsIn[| i]);
	draw_text(x, _damageLine, "-" + string(damageValuesIn[| i]));
	_damageLine += (font_get_size(fnt_blocks) * 1.5);
}
draw_set_alpha(1)