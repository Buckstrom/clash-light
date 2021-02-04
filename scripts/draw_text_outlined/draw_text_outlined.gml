// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_text_outlined(xx, yy, string, outlinecolor, stringcolor){
	//Defaults
	if (!outlinecolor) {
		outlinecolor = c_black;
		if (!stringcolor) {
			stringcolor = draw_get_color();
		}
	}
	//Outline
	draw_set_color(outlinecolor);  
	draw_text(xx+1, yy+1, string);  
	draw_text(xx-1, yy-1, string);  
	draw_text(xx,   yy+1, string);  
	draw_text(xx+1,   yy, string);  
	draw_text(xx,   yy-1, string);  
	draw_text(xx-1,   yy, string);  
	draw_text(xx-1, yy+1, string);  
	draw_text(xx+1, yy-1, string);  

	//Text  
	draw_set_color(stringcolor);  
	draw_text(xx, yy, string); 
}
function draw_text_outlined_ext(xx, yy, string, sep, w, outlinecolor, stringcolor){
	//Defaults
	if (!outlinecolor) {
		outlinecolor = c_black;
	}
	if (!stringcolor) {
		stringcolor = draw_get_color();
	}
	//Outline
	draw_set_color(outlinecolor);  
	draw_text_ext(xx+1, yy+1, string, sep, w);  
	draw_text_ext(xx-1, yy-1, string, sep, w);  
	draw_text_ext(xx,   yy+1, string, sep, w);  
	draw_text_ext(xx+1,   yy, string, sep, w);  
	draw_text_ext(xx,   yy-1, string, sep, w);  
	draw_text_ext(xx-1,   yy, string, sep, w);  
	draw_text_ext(xx-1, yy+1, string, sep, w);  
	draw_text_ext(xx+1, yy-1, string, sep, w);  

	//Text  
	draw_set_color(stringcolor);  
	draw_text_ext(xx, yy, string, sep, w); 
}