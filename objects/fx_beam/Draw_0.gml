/// @description Insert description here
// You can write your code in this editor
draw_set_color(beamColor)
var _beamElapsed = alarm[0] / beamTime
var _beamSpread = (beamWidth / 2)
//var _beamSpread = beamWidth / 2
var _destOffsetY = (beamDest.appear_height / 2)
var _beamPointY = beamStart.y - (((beamStart.y - (beamDest.y + _destOffsetY)) / beamTime) * (beamTime - alarm[0]));
var _beamPointX = beamDest.x + ((beamStart.x - beamDest.x) / beamTime) * alarm[0];
//var _beamPoint = beamDest.y;
draw_triangle(beamStart.x, beamStart.y, _beamPointX - _beamSpread, _beamPointY, _beamPointX + _beamSpread, _beamPointY, false)