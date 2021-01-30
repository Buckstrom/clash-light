/// @description Insert description here
// You can write your code in this editor
randomize()
//Range changers
if (debug_valueEdit) {
	editMin = instance_create_layer(x,y,"GUI", button_adjust_integer);
	editMax = instance_create_layer(x + marginX,y,"GUI", button_adjust_integer);
	editMin.editValue = lvRangeMin
	editMax.editValue = lvRangeMax
	editMin.label = "Min"
	editMax.label = "Max"
	editExe = instance_create_layer(x,y + (marginY * 3),"GUI", button_adjust_bool);
	editExe.editValue = allowExe;
	editExe.label = "Spawn .Exe's"
	editSpc = instance_create_layer(x,y + (marginY * 4),"GUI", button_adjust_bool);
	editSpc.editValue = allowSpc;
	editSpc.label = "Spawn Special"
	editFill = instance_create_layer(x,y + (marginY * 5),"GUI", button_adjust_bool);
	editFill.editValue = spawnToFill;
	editFill.label = "Fill Spaces"
}