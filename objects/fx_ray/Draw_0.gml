/// @description Insert description here
// You can write your code in this editor
draw_set_color(fxColor)
var _beamSpread = (fxWidth / 2)
//var _beamSpread = beamWidth / 2
var _destOffsetY = (fxDest.appear_height / 2)
var _beamPointY = fxStart.y - (((fxStart.y - (fxDest.y + _destOffsetY)) / fxTime) * (fxTime - alarm[0]));
var _beamPointX = fxDest.x + ((fxStart.x - fxDest.x) / fxTime) * alarm[0];
//var _beamPoint = beamDest.y;
draw_triangle(fxStart.x, fxStart.y, _beamPointX - _beamSpread, _beamPointY, _beamPointX + _beamSpread, _beamPointY, false)
draw_triangle(_beamPointX, _beamPointY, fxStart.x - _beamSpread, fxStart.y, fxStart.x + _beamSpread, fxStart.y, false)