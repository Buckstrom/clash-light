#macro mAPPEAR_COORDS x - (appear_width / 2), y - (appear_height / 2), x + (appear_width / 2), y + (appear_height / 2)

reg_space = 0;
comboCount = 0;
damageSum = 0;
comboMultiplier = 0;
trapQueue = ds_queue_create();
damageValuesIn = ds_list_create();
damageColorsIn = ds_list_create();

isHovering = false;
debuffs = ds_map_create();
enum debuff_properties {
	duration,
	factor, //(multiplier, reduction, amount)
	misc
}