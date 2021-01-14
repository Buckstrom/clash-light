//check if mouse is hovering over an entity
var _hoverActive = false;
for (i = 0; i < ds_list_size(reg_party); ++i) {
	if (reg_party[| i].isHovering) {
		var _hoverActive = true;
	}
}
for (i = 0; i < ds_list_size(reg_enemy); ++i) {
	if (reg_enemy[| i].isHovering) {
		var _hoverActive = true;
	}
}
if (!_hoverActive) {
	hovering_partymem = -1;
	hovering_enemy = -1;
}

if (mouse_check_button_pressed(mb_left)) {
	switch (currentState) {
		case battleState.intro:
		//transition from intro to weapon selection (first turn)
		currentState = battleState.p_choice;
		break;
		case battleState.p_choice:
		//check if weapon is highlighted
		if (currentWep != -1 && currentTrack != -1) {
			//check current inventory quantity
			if (ds_grid_get(mCURRENT_MEM.inventory[? currentTrack], currentWep, 0) > 0 || debug_ignoreQuantities) {
				mCURRENT_MEM.choiceWep = currentWep;
				mCURRENT_MEM.choiceTrack = currentTrack;
				//find targeting mode for weapon: 0 - single, 1 - all
				var _targetMode = ds_grid_get(mWEP.wTracks[? currentTrack], currentWep, 4)
				switch (_targetMode) {
					default:
					currentState = battleState.p_target;
					break;
					case 1:
					mCURRENT_MEM.choiceTarget = -2;
					//change active party member to the next undecided one, otherwise move to anim
					for (var _partyDecided = 0; _partyDecided < ds_list_size(reg_party); ++_partyDecided) {
						//stop at a member that is undecided
						if (mCURRENT_MEM.choiceTarget = -1) {
							break;
						}
						//otherwise, check the next
						if (current_partymem < ds_list_size(reg_party) - 1) {
							++current_partymem
						}
						else {
							current_partymem = 0;
						}
					}
					if (_partyDecided == ds_list_size(reg_party)) {
						currentState = battleState.p_attack;
					}
					break;
				}
			}
		}
		break;
		case battleState.p_target:
		//target a hovered enemy
		if (hovering_enemy != -1) {
			mCURRENT_MEM.choiceTarget = hovering_enemy
			currentState = battleState.p_choice
			//change active party member to the next undecided one, otherwise move to anim
			for (var _partyDecided = 0; _partyDecided < ds_list_size(reg_party); ++_partyDecided) {
				//stop at a member that is undecided
				if (mCURRENT_MEM.choiceTarget = -1) {
					break;
				}
				//otherwise, check the next
				if (current_partymem < ds_list_size(reg_party) - 1) {
					++current_partymem
				}
				else {
					current_partymem = 0;
				}
			}
			//begin attack calculations if all party members have made a decision
			if (_partyDecided == ds_list_size(reg_party)) {
				currentState = battleState.p_attack;
			}
		}
		break;
		case battleState.e_attack:
		currentState = battleState.p_choice;
		break;
	}
}

if (mouse_check_button_pressed(mb_right)) {
	switch (currentState) {
		case battleState.p_choice:
		//deselect a weapon choice
		if (hovering_partymem != -1) {
			clear_target(mHOVERING_MEM);
			break;
		}
		if (hovering_enemy != -1) {
			break;
		}
		clear_target(mCURRENT_MEM)
		break;
		case battleState.p_target:
		clear_target(mCURRENT_MEM);
		currentState = battleState.p_choice
		break
	}
}

if (currentState != battleState.p_attack && inst_calc != -1) {
		inst_calc = -1;
}

switch (currentState) {
	case battleState.p_choice:
	//clear dead enemies
	if (clearDead) {
		var _oldEnemyRow = ds_list_size(reg_enemy);
		var _newEnemyRow = _oldEnemyRow;
		for (var i = 0; i < _oldEnemyRow;) {
			//check if enemy exists
			var _clearEnemy = is_undefined(reg_enemy[| i])
			//check enemy if their HP has depleted; destroy enemy if true
			if (!_clearEnemy) {
				if !(reg_enemy[| i].currentHP > 0) {
					instance_destroy(reg_enemy[| i]);
					_clearEnemy = true;
				}
			}
			switch (_clearEnemy) {
				case true:
				ds_list_delete(reg_enemy, i);
				--_newEnemyRow
				break;
				case false:
				//check next enemy in the row
				++i
				break;
			}
			//if checking beyond range, end loop
			if (i = _newEnemyRow) {
				break;
			}
		}
		refresh_enemy_row();
		clearDead = false;
	}
	break;
	case battleState.p_attack:
	if (inst_calc = -1) {
		inst_calc = instance_create_layer(0,0,self.layer,obj_master_attackcalc)
	}
	break;
	default:
	break;
}