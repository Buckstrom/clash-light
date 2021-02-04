// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_sprite_outlined(sprite, subimg, x, y, size){
	var offset = size;
	var xx = x;
	var yy = y;
	for (xx = x-offset; xx <= x+offset; xx += offset) {  
	    for (yy = y-offset; yy <= y+offset; yy += offset) {
	          draw_sprite_ext(sprite, subimg, xx, yy, 1, 1, 0, c_black, 1);
	     }
	}
	draw_sprite(sprite, subimg, x, y)
}
function draw_sprite_outlined_ext(sprite, subimg, x, y,xscale,yscale,rot,col,alpha,size){
	var offset = size;
	var xx = x;
	var yy = y;
	for (xx = x-offset; xx <= x+offset; xx += offset) {  
	    for (yy = y-offset; yy <= y+offset; yy += offset) {
	          draw_sprite_ext(sprite, subimg, xx, yy, xscale, yscale, rot, c_black, alpha);
	     }
	}
	draw_sprite_ext(sprite, subimg, x, y, xscale,yscale,rot,col,alpha)
}