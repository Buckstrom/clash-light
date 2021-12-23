lvRangeMin = editMin.editValue
lvRangeMax = editMax.editValue
allowExe = editExe.editValue
allowSpc = editSpc.editValue
spawnToFill = editFill.editValue
triggerSpawn = editSpawn.editValue
/// Spawn enemy to fill row
if ((spawnToFill || triggerSpawn) && ds_list_size(mBATTLE.reg_enemy) < rowSize) {
	var _addEnemy = instance_create_layer(0,0, "Instances", ent_enemy)
	//assign name, random level and place
	_addEnemy.given_name = "Suit";
	_addEnemy.level = irandom_range(lvRangeMin, lvRangeMax)
	_addEnemy.isExe = (allowExe && random(1) < rateExe);
	switch (allowSpc) {
		case true:
		_addEnemy.specialty = irandom_range(specialty_types.none, specialty_types.def);
		break;
		case false:
		_addEnemy.specialty = specialty_types.none;
		break;
	}
	set_enemy_hp(_addEnemy, true);
	//append enemy row with new enemy
	ds_list_insert(mBATTLE.reg_enemy, 0, _addEnemy);
	refresh_row(mBATTLE.reg_enemy, entity_type.enemy);
}