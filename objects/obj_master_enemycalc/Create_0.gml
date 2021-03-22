//#macro mECALC obj_master_ememycalc

//order attacks in priority queue
attackCount = 0;
attackQueue = ds_priority_create();
//register all alive enemies
for (var i = ds_list_size(mBATTLE.reg_enemy) - 1; i > -1; ++i) {
	var _enemy = mBATTLE.reg_enemy[| i]
	//if enemy is dead, check next one
	if !(_enemy.currentHP > 0) {
		continue;
	}
	var _choice = -1;
	var _target = -2;
	//33% to target all (placeholder)
	if (random(1) > chanceTargetAll) {
		_target = irandom_range(0, ds_list_size(mBATTLE.reg_party));
	}
	//if enemy is alive, generate an attack and enqueue it
	if (_enemy.nextAction == "ATTACK") {
		_choice = {
			attacker : _enemy,
			level : _enemy.level,
			target : _target,
			//damage - placeholder
			damage : irandom_range(1,10),
			spec : _enemy.specialty
		}
	}
	if (_choice > -1) {
		ds_priority_add(attackQueue, _choice, i);
		++attackCount;
	}
	//else _choices[i] = script_execute(asset_get_index("actE_" + _enemy.nextAction), _enemy);
}

//begin attack sequence
alarm[0] = battleTick
activeAttack = ds_priority_find_min(attackQueue)