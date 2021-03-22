/// @description Insert description here
// You can write your code in this editor
randomize()
//Range changers
if (debug_valueEdit) {
	var _space = 0
	editMin = instance_create_layer(x,y,"GUI", button_adjust_integer);
	editMax = instance_create_layer(x + marginX,y,"GUI", button_adjust_integer);
	editMin.editValue = lvRangeMin
	editMax.editValue = lvRangeMax
	editMin.label = "Min"
	editMax.label = "Max";
	_space += 2;
	editExe = instance_create_layer(x,y + (marginY * _space),"GUI", button_adjust_bool);
	editExe.editValue = allowExe;
	editExe.label = "Spawn .Exe's";
	++_space;
	editSpc = instance_create_layer(x,y + (marginY * _space),"GUI", button_adjust_bool);
	editSpc.editValue = allowSpc;
	editSpc.label = "Spawn Special";
	++_space;
	editFill = instance_create_layer(x,y + (marginY * _space),"GUI", button_adjust_bool);
	editFill.editValue = spawnToFill;
	editFill.label = "Fill Spaces";
	++_space;
	editSpawn = instance_create_layer(x + (marginX * (1/2)),y + (marginY * _space),"GUI", button_adjust_trigger);
	editSpawn.editValue = triggerSpawn;
	editSpawn.label = "Add"
	instance_create_layer(x + (marginX * 2),y + (marginY * _space),"GUI", button_clear_enemy);
}