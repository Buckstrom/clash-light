/// @description Insert description here
// You can write your code in this editor
draw_set_color(fxColor)
var _waveElapsed = (fxTime - alarm[0]) / fxTime;
draw_pie(fxStart.x, fxStart.y, 1, 1, fxColor, view_hport[0] - (_waveElapsed * view_hport[0]), 0 + (_waveElapsed * 0.75))