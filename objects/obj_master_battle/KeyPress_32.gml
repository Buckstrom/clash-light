/*if (current_partymem < ds_list_size(reg_party) - 1) {
	++current_partymem
}
else {
	current_partymem = 0
}
//add a new enemy if under capacity
if (ds_list_size(reg_enemy) < temp_AmtEnemy) {
	var _addEnemy = instance_create_layer(view_wport[0] * ((2 + i) / (3 + temp_AmtEnemy)), 92, "Instances", ent_enemy)
	//assign name and place
	_addEnemy.given_name = "Suit";
	_addEnemy.reg_space = i;
	//append enemy row with new enemy
	ds_list_insert(reg_enemy, 0, _addEnemy);
	refresh_row(mBATTLE.reg_enemy, entity_type.enemy);
}