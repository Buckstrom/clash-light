// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_text_outlined(xx, yy, outlinecolor, stringcolor, string){
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