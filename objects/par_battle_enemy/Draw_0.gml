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
	draw_rectangle_width(mAPPEAR_COORDS, 2)
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
_tagText += "\n" + given_name;
draw_text_ext(x, y - (appear_height / 2), _tagText, font_get_size(fnt_blocks) * 1.5, view_wport[0])
//draw enemy health
draw_set_valign(fa_top)
var _showHP = string(currentHP) + " / " + string(maxHP)
if (currentHP < prevHP) {
	_showHP += "\nDamage: " + string(prevHP - currentHP);
}
draw_text(x, y + (appear_height / 2), _showHP)
//draw debuff list in order
//var _debuffList = "";
var _debuffAmt = ds_map_size(debuffs);
var _trapAmt = ds_queue_size(trapQueue);
var _n = 0;
/*if (!is_undefined(ds_queue_head(trapQueue))) {
	_debuffList += "trap: " + string(ds_queue_head(trapQueue).damage) + "\n";
}*/
for (var i = 0; i < ds_list_size(mWEP.debuffNames); ++i) {
	if (ds_map_exists(debuffs, mWEP.debuffNames[| i])) {
		//_debuffList += mWEP.debuffNames[| i]
		var _checkDebuff = mWEP.debuffNames[| i]
		//draw debuff sprite
		draw_sprite(asset_get_index("ico_" + mWEP.debuffNames[| i]), 0, x + (appear_width / 2) + 12, y - (appear_height / 2) + 14 + (_n * 24))
		//draw_line_width(x + (appear_width / 2) + 22, y - (appear_height / 2) + (_n * 24), x + (appear_width / 2) + 22, y - (appear_height / 2) + (_n * 24) + 24, 2);
		//draw debuff properties
		draw_set_halign(fa_left);
		draw_set_color(c_aqua);
		draw_set_valign(fa_middle)
		draw_text(x + (appear_width / 2) + 28, y - (appear_height / 2) + 20 + (_n * 24), string(debuffs[? _checkDebuff][debuff_properties.duration]))
		if (_checkDebuff == "lured") {
			draw_set_color(c_lime)
			draw_text(x + (appear_width / 2) + 28, y - (appear_height / 2) + 6 + (_n * 24), string(100 * debuffs[? _checkDebuff][debuff_properties.factor]));
		}
		++_n
		/*if (mWEP.debuffNames[| i] == "lured") {
			_debuffList += ": " + string(100 * debuffs[? "lured"][debuff_properties.factor]) + "%";
		}
		if (_n < _debuffAmt) {
			_debuffList += "\n"
		}*/
	}
}
draw_set_color(c_white)
if (_debuffAmt > 0) {
	draw_rectangle_width(x + (appear_width / 2), y - (appear_height / 2), x + (appear_width / 2) + 24, y - (appear_height / 2) + ((_debuffAmt - 1) * 24) + 24, 2)
}
if (_trapAmt > 0) {
	draw_rectangle_width(x - (appear_width / 2), y - (appear_height / 2), x - (appear_width / 2) + 24, y - (appear_height / 2) + ((_trapAmt - 1) * 24) + 24, 2)
	draw_sprite(ico_trapped, 0, x - (appear_width / 2) - 11 + 24, y - (appear_height / 2) + 13);
	draw_set_halign(fa_left)
	draw_set_valign(fa_middle)
	draw_set_color(c_red)
	draw_text(x - (appear_width / 2) + 4, y - (appear_height / 2) + 14 + 20, string(ds_queue_head(trapQueue).damage));
}
draw_set_valign(fa_middle)
draw_set_font(fnt_blocks)
//draw_text(x, y, _debuffList);
//draw received damage
var _damageLine = (y + (appear_height / 2)) + (font_get_size(fnt_blocks) * 3.5)
for (var i = 0; i < ds_list_size(damageValuesIn); ++i) {
	draw_set_color(damageColorsIn[| i]);
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	if (damageValuesIn[| i] != 0) {
		draw_text(x, _damageLine, "-" + string(damageValuesIn[| i]));
	}
	_damageLine += (font_get_size(fnt_blocks) * 1.5);
}
draw_set_alpha(1)