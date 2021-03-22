if (hue > 256) {
	hue = 0
}
var _totalTracks = ds_list_size(mWEP.wTracks)
/*var _enemyBack = {
	x1 : 0,
	y1 : 0,
	//y1 : ((view_hport[0]) * mBATTLE.wepgui_margin) - ((_totalTracks)* (mBATTLE.button_height / 2)) - (mBATTLE.button_height / 2) - 1,
	x2 : view_wport[0],
	y2 : ((view_hport[0]) * mBATTLE.wepgui_margin) + (_totalTracks * (mBATTLE.button_height / 2)) - (mBATTLE.button_height / 2) - 1
}*/
draw_set_alpha(1)
var _color = make_color_hsv(++hue, 75, 75)
var _enemyBack = {
	x1 : 0,
	y1 : 0,
	x2 : view_wport[0],
	y2 : ((view_hport[0]) * mBATTLE.wepgui_margin) - ((_totalTracks)* (mBATTLE.button_height / 2)) - (mBATTLE.button_height / 2) - 1
}
draw_rectangle_color(mENEMYBACK_COORDS, _color, _color, c_black, c_black, false)
var _enemyBack = {
	x1 : 0,
	y1 : ((view_hport[0]) * mBATTLE.wepgui_margin) + (_totalTracks * (mBATTLE.button_height / 2)) - (mBATTLE.button_height / 2) - 1,
	//y1 : ((view_hport[0]) * mBATTLE.wepgui_margin) - ((_totalTracks)* (mBATTLE.button_height / 2)) - (mBATTLE.button_height / 2) - 1,
	x2 : view_wport[0],
	y2 : view_hport[0]
}
draw_rectangle_color(mENEMYBACK_COORDS, c_black, c_black, _color, _color, false)