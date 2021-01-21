// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function anim_beam(source, enemy, color, time){
	var _fx = instance_create_layer(0,0,self.layer,fx_beam)
	_fx.beamStart = source;
	_fx.beamDest = enemy;
	_fx.beamColor = color;
	_fx.beamTime = time / 2;
	_fx.alarm[0] = time / 2;
	_fx.beamHold = time / 2;
}