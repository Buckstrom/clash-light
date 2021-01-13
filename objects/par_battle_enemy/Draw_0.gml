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
draw_text_ext(x, y - (appear_height / 2), "Level " + string(level) + "\n" + string(currentHP) + " / " + string(maxHP), font_get_size(fnt_blocks) * 1.5, view_wport[0])
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
		if (_n++ < _debuffAmt) {
			_debuffList += "\n"
		}
	}
}
draw_set_valign(fa_middle)
draw_text(x, y, _debuffList);