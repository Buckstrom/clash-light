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
//LMB checks
if (mouse_check_button_pressed(mb_left)) {
	switch (currentState) {
		case battleState.intro:
		//transition from intro to weapon selection (first turn)
		currentState = battleState.p_choice;
		break;
		case battleState.p_choice:/*
		//check if action is highlighted
		if (actMisc != false) {
			//set party member to action
			mCURRENT_MEM.nextAction = actMisc;
			battle_check_ready();
		}
		//check if weapon is highlighted
		if (currentWep != -1 && currentTrack != -1) {
			//check current inventory quantity
			if (ds_grid_get(mCURRENT_MEM.inventory[? currentTrack], currentWep, 0) > 0 || debug_ignoreQuantities) {
				mCURRENT_MEM.choiceWep = currentWep;
				mCURRENT_MEM.choiceTrack = currentTrack;
				mCURRENT_MEM.nextAction = "ATTACK";
				//find targeting mode for weapon: 0 - single, 1 - all
				var _targetMode = ds_grid_get(mWEP.wTracks[? currentTrack], currentWep, 4)
				switch (_targetMode) {
					default:
					currentState = battleState.p_target;
					break;
					case 1:
					mCURRENT_MEM.choiceTarget = -2;
					battle_check_ready();
					break;
				}
			}
		}*/
		break;
		case battleState.p_target:
		//target a hovered enemy
		if (hovering_enemy != -1) {
			mCURRENT_MEM.choiceTarget = hovering_enemy
			currentState = battleState.p_choice
			battle_check_ready();
		}
		break;
		case battleState.e_finish:
		currentState = battleState.p_choice;
		refresh_row(mBATTLE.reg_enemy, entity_type.enemy)
		clear_damage_display_row(reg_enemy);
		clear_target_row();
		decrement_debuffs_row(reg_enemy);
		break;
	}
}
///RMB actions
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
		break;
		case battleState.e_finish:
		refresh_row(mBATTLE.reg_enemy, entity_type.enemy)
		var _e = 0;
		repeat (ds_list_size(reg_enemy)) {
			set_enemy_hp(reg_enemy[| _e], true, reg_enemy[| _e].turnHP);
			++_e;
		}
		clearDead = false;
		currentState = battleState.p_choice;
		clear_damage_display_row(reg_enemy);
		clear_target_row();
		decrement_debuffs_row(reg_enemy);
		//revert_debuffs_row();
		refresh_row(mBATTLE.reg_enemy, entity_type.enemy)
		break;
	}
}

if (currentState != battleState.p_attack && inst_calc != -1) {
		inst_calc = -1;
}

switch (currentState) {
	case battleState.p_choice:
	//clear dead enemies
	if (clearDead) {
		remove_dead_row(mBATTLE.reg_enemy);
		refresh_row(mBATTLE.reg_enemy, entity_type.enemy);
		clearDead = false;
	}
	//instantiate weapon gui
	if (inst_wepgui = -1) {
		inst_wepgui = instance_create_layer(wepgui_x,wepgui_y,self.layer,obj_gui_weapon)
		inst_wepgui.row_amount = ds_list_size(mWEP.wTracks);
		inst_wepgui.row_length = 8;
		inst_wepgui.viewing_mem = mCURRENT_MEM;
	}
	break;
	//instantiate attack manager
	case battleState.p_attack:
	if (inst_calc = -1) {
		inst_calc = instance_create_layer(0,0,self.layer,obj_master_attackcalc)
	}
	break;
	case battleState.e_attack:
	if (!enemyWillAttack) {
		currentState = battleState.e_finish
	}
	default:
	break;
}
//switch party members with a-d or arrow keys
if (currentState != battleState.p_target) {
	if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))){
		if (current_partymem < ds_list_size(reg_party) - 1) {
			++current_partymem
		}
		else {
			current_partymem = 0
		}
	}
	if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"))){
		if (current_partymem > 0) {
			--current_partymem
		}
		else {
			current_partymem = ds_list_size(reg_party) - 1
		}
	}
}