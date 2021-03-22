//Set new member to view
var _currentMem = mBATTLE.reg_party[| mBATTLE.current_partymem]
var _hoveringMem = mBATTLE.reg_party[| mBATTLE.hovering_partymem]
viewing_mem = _currentMem;
if (_hoveringMem && _currentMem != _hoveringMem) {
	viewing_mem = _hoveringMem;
}
var _hoverColumnRaw = (mouse_x - (x - (row_length * (button_width / 2)))) / button_width
hovering_column = floor(_hoverColumnRaw);
var _hoverRowRaw = (mouse_y - (y - (row_amount * (button_height / 2)) - (button_height / 2))) / button_height;
hovering_row = floor(_hoverRowRaw);
hovering_trackName = mWEP.trackNames[| hovering_row];
hovering_pres = (_hoverColumnRaw > row_length && _hoverColumnRaw < row_length + 0.5);
hovering_trackToggle = (_hoverColumnRaw > -0.5 && _hoverColumnRaw < 0);
hovering_misc = (_hoverColumnRaw > row_length + 0.5 && _hoverColumnRaw < row_length + 1.5);

var _destroy = false;
//LMB Actions
if (mouse_check_button_pressed(mb_left)) {
	//toggle prestige
	if (hovering_pres) {
		var _togglePres = function(row) {
			var _track = mWEP.trackNames[| row]
			viewing_mem.invPres[? _track] = !viewing_mem.invPres[? _track]
		}
		var _unifyPres = function(row, unify) {
			var _track = mWEP.trackNames[| row]
			viewing_mem.invPres[? _track] = unify
		}
		switch (hovering_row) {
			default:
			_togglePres(hovering_row);
			break;
			case row_amount:
			var _i = 0;
			var _anyPres = false;
			repeat (row_amount) {
				if (_anyPres = viewing_mem.invPres[? mWEP.trackNames[| _i++]]) {
					_anyPres = true;
					break;
				}
			}
			var _i = 0;
			repeat (row_amount) {
				_unifyPres(_i++, _anyPres);
			}
			break;
		}
	}
	//toggle track
	if (hovering_trackToggle && debug_modifyTracks &&
		hovering_row > -1 &&
		hovering_row < row_amount + 1) {
		var _toggleTrack = function(row) {
			var _track = mWEP.trackNames[| row]
			switch (ds_map_exists(viewing_mem.inventory, _track)) {
				case false:
				initialize_track(viewing_mem, _track, true);
				add_weapon(viewing_mem, _track, 7, 1)
				refresh_tracks(viewing_mem, viewing_mem.invPres[? _track]);
				break;
				case true:
				ds_map_delete(viewing_mem.inventory, _track);
				refresh_tracks(viewing_mem, viewing_mem.invPres[? _track]);
				break;
			}
		}
		var _unifyTrack = function(row, unify) {
			var _track = mWEP.trackNames[| row]
			switch (unify) {
				case false:
				if ds_map_exists(viewing_mem.inventory, _track) {
					break;
				}
				initialize_track(viewing_mem, _track, true);
				add_weapon(viewing_mem, _track, 7, 1)
				refresh_tracks(viewing_mem, viewing_mem.invPres[? _track]);
				break;
				case true:
				ds_map_delete(viewing_mem.inventory, _track);
				refresh_tracks(viewing_mem, viewing_mem.invPres[? _track]);
				break;
			}
		}
		switch (hovering_row) {
			default:
			_toggleTrack(hovering_row);
			break;
			case row_amount:
			var _i = 0;
			var _anyTrack = false;
			repeat (row_amount) {
				if (_anyTrack = !ds_map_exists(viewing_mem.inventory, mWEP.trackNames[| _i++])) {
					_anyTrack = true;
					break;
				}
			}
			var _i = 0;
			repeat (row_amount) {
				_unifyTrack(_i++, _anyTrack);
			}
			break;
		}
	}
	//check if action is highlighted
	if (is_highlighting_misc()) {
		//set party member to action
		var _hoveringAction = row_amount - (hovering_row + 1)
		_currentMem.nextAction = _currentMem.miscInv[| _hoveringAction];
		_destroy = battle_check_ready();
	}
	//check if weapon is highlighted
	if (is_highlighting_weapon() && ds_map_exists(_currentMem.inventory, hovering_trackName)) {
		switch (keyboard_check(vk_shift)) {
			case false:
			//check current inventory quantity
			if (ds_grid_width(_currentMem.inventory[? hovering_trackName]) > hovering_column) {
				if (ds_grid_get(_currentMem.inventory[? hovering_trackName], hovering_column, 0) > 0 || debug_ignoreQuantities) {
					_currentMem.choiceWep = hovering_column;
					_currentMem.choiceTrack = hovering_trackName;
					_currentMem.nextAction = "ATTACK";
					//find targeting mode for weapon: 0 - single, 1 - all
					var _targetMode = ds_grid_get(mWEP.wTracks[? hovering_trackName], hovering_column, 4)
					switch (_targetMode) {
						default:
						mBATTLE.currentState = battleState.p_target;
						_destroy = true;
						break;
						case 1:
						_currentMem.choiceTarget = -2;
						_destroy = battle_check_ready();
						break;
					}
				}
			}
			break;
			case true:
			if (debug_modifyTracks) {
				ds_map_delete(viewing_mem.inventory, hovering_trackName);
				initialize_track(viewing_mem, hovering_trackName, true, hovering_column);
				refresh_tracks(viewing_mem, viewing_mem.invPres[? hovering_trackName]);
			}
		}
	}
}
if (_destroy) {
	//remove instance id and destroy
	mBATTLE.inst_wepgui = -1;
	instance_destroy(self);
}