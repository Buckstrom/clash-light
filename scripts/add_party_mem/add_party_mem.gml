// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function add_party_mem(clroster, char, space){
	//create party member
	var _addToParty = instance_create_layer(0,0, "Instances", ent_partymem)
	//assign name and place
	_addToParty.given_name = clroster[# char, clchar_properties.name];
	_addToParty.maxHP = clroster[# char, clchar_properties.maxhp];
	_addToParty.reg_space = space;
	//check tracks to add
	var _track = ""
	for (var t = 0; t < ds_map_size(mWEP.wTracks); ++t) {
		//parse track data
		var _wepStats = clroster[# char, clchar_properties.wep + t]
		var _wepLv = real(string_digits(_wepStats));
		var _wepPres = string_count("p",_wepStats) > 0;
		if (_wepLv > -1) {
			_track = mWEP.trackNames[| t]
			initialize_track(_addToParty, _track, _wepPres, _wepLv);
			add_weapon(_addToParty, _track, _wepLv, 1)
		}
	}
	refresh_tracks(_addToParty, 1);
	//register party member
	mBATTLE.reg_party[| char] = _addToParty;
	refresh_row(mBATTLE.reg_party, entity_type.party);
}
function change_party_mem(clroster, char, space){
	//create party member
	var _addToParty = mBATTLE.reg_party[| space]
	//assign name and place
	_addToParty.given_name = clroster[# char, clchar_properties.name];
	_addToParty.maxHP = clroster[# char, clchar_properties.maxhp];
	_addToParty.currentHP = clroster[# char, clchar_properties.maxhp];
	_addToParty.reg_space = space;
	//check tracks to add
	var _track = ""
	for (var t = 0; t < ds_map_size(mWEP.wTracks); ++t) {
		_track = mWEP.trackNames[| t]
		if (ds_map_exists(_addToParty.inventory, _track)) {
			ds_map_delete(_addToParty.inventory, _track);
			refresh_tracks(_addToParty, _addToParty.invPres[? _track]);
		}
		ds_map_delete(_addToParty.invPres, _track);
		//parse track data
		var _wepStats = clroster[# char, clchar_properties.wep + t]
		var _wepLv = real(string_digits(_wepStats));
		var _wepPres = string_count("p",_wepStats) > 0;
		if (_wepLv > 0) {
			initialize_track(_addToParty, _track, _wepPres, _wepLv - 1);
			add_weapon(_addToParty, _track, _wepLv - 1, 1)
		}
	}
	refresh_tracks(_addToParty, 0);
	//register party member
	refresh_row(mBATTLE.reg_party, entity_type.party);
}