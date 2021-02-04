// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_rectangle_width(x1, y1, x2, y2, w){
	draw_line_width(x1, y1, x2, y1, w);
	draw_line_width(x2, y1 - (w / 2), x2, y2 + (w / 2), w);
	draw_line_width(x1, y2, x2, y2, w);
	draw_line_width(x1, y1 - (w / 2), x1, y2 + (w / 2), w);
}