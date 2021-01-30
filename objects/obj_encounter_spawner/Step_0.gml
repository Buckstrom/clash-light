lvRangeMin = editMin.editValue
lvRangeMax = editMax.editValue
allowExe = editExe.editValue
allowSpc = editSpc.editValue
spawnToFill = editFill.editValue
/// Spawn enemy to fill row
if (spawnToFill && ds_list_size(mBATTLE.reg_enemy) < rowSize) {
	var _addEnemy = instance_create_layer(0,0, "Instances", par_battle_enemy)
	//assign name, random level and place
	_addEnemy.given_name = "Suit";
	_addEnemy.level = irandom_range(lvRangeMin, lvRangeMax)
	_addEnemy.isExe = (allowExe && random(1) < rateExe);
	_addEnemy.specialty = (allowSpc && irandom_range(specialty_types.none, specialty_types.def));
	set_enemy_hp(_addEnemy, true);
	//append enemy row with new enemy
	ds_list_insert(mBATTLE.reg_enemy, 0, _addEnemy);
	refresh_enemy_row();
}