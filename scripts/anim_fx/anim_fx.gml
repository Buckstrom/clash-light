// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function anim_fx(fx, source, enemy, color, time){
	var _inst = instance_create_layer(0,0,self.layer,fx)
	_inst.fxStart = source;
	if (is_undefined(enemy)) {
		_inst.fxDest = instance_create_layer(source.x, targetRow[| 0].y, _inst.layer, dummy_aimspot)
	}
	else {
		_inst.fxDest = enemy;
	}
	_inst.fxColor = color;
	_inst.fxTime = time / 2;
	_inst.alarm[0] = time / 2;
	_inst.fxHold = time / 2;
}