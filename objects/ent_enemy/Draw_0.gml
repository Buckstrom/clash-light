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
	draw_sprite(sprite_index, 0, x, y)
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
switch (specialty) {
	case specialty_types.atk:
	_tagText += " +ATK"
	break
	case specialty_types.def:
	_tagText += " +DEF"
	break
	default:
	break;
}
_tagText += "\n" + given_name;
draw_text_outlined_ext(x, y - (appear_height / 2), _tagText, font_get_size(fnt_blocks) * 1.5, view_wport[0])
//draw enemy health
draw_set_valign(fa_top)
var _showHP = string(currentHP) + " / " + string(maxHP)
if (currentHP < prevHP) {
	_showHP += "\nDamage: " + string(prevHP - currentHP);
}
draw_text_outlined_ext(x, y + (appear_height * (1/2)), _showHP, font_get_size(fnt_blocks) * 2, appear_width * 1.5)
//draw healthbar
draw_healthbar(x - (appear_width / 2), y + (appear_height * (4/5)) - 6 + 1, x + (appear_width / 2), y + (appear_height * (4/5)) + 6 + 1, currentHP / maxHP * 100, c_grey, c_red, c_lime, 0, true, true)
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
		draw_sprite_outlined(asset_get_index("ico_" + mWEP.debuffNames[| i]), 0, x + (appear_width / 2) + 12, y - (appear_height / 2) + 14 + (_n * 24), 1)
		//draw_line_width(x + (appear_width / 2) + 22, y - (appear_height / 2) + (_n * 24), x + (appear_width / 2) + 22, y - (appear_height / 2) + (_n * 24) + 24, 2);
		//draw debuff properties
		draw_set_halign(fa_left);
		draw_set_color(c_aqua);
		draw_set_valign(fa_middle)
		draw_text_outlined(x + (appear_width / 2) + 28, y - (appear_height / 2) + 14 + (_n * 24), string(debuffs[? _checkDebuff][debuff_properties.duration]))
		//draw debuff factor
		var _drawFactor = false;
		switch (_checkDebuff) {
			case "lured":
			draw_set_color(mWEP.trackColors[? "lure"])
			_drawFactor = "+" + string(floor(100 * debuffs[? _checkDebuff][debuff_properties.factor])) + "%"
			break;
			case "marked":
			draw_set_color(mWEP.trackColors[? "throw"])
			_drawFactor = "+" + string(floor(100 * debuffs[? _checkDebuff][debuff_properties.factor])) + "%"
			break;
			case "jumped":
			draw_set_color(mWEP.trackColors[? "zap"])
			_drawFactor = string_format(debuffs[? _checkDebuff][debuff_properties.factor],1,1) + "x"
			break;
		}
		if (_drawFactor != false) {
			draw_set_halign(fa_right);
			//if (isHovering) {
			//	draw_set_color(merge_color(draw_get_color, c_black, 0.5));
			//}
			draw_text_outlined(x + (appear_width / 2), y - (appear_height / 2) + 14 + (_n * 24), _drawFactor);
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
	if (is_undefined(damageValuesIn[| i])) {
		continue;
	}
	draw_set_color(damageColorsIn[| i]);
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	if (damageValuesIn[| i] > 0) {
		draw_text_outlined(x, _damageLine, "-" + string(damageValuesIn[| i]));
	}
	_damageLine += (font_get_size(fnt_blocks) * 1.125);
}
draw_set_alpha(1)