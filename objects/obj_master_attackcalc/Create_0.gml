//#macro mCALC obj_master_attackcalc

var _choices;
//register weapon choices unordered
for (var i = 0; i < ds_list_size(sourceRow); ++i) {
	var _attacker = sourceRow[| i]
	if (_attacker.nextAction == "ATTACK") {
		_choices[i] = {
			attacker : _attacker,
			source : i,
			trackname : _attacker.choiceTrack,
			level : _attacker.choiceWep,
			target : _attacker.choiceTarget,
			damage : real(ds_grid_get(mWEP.wTracks[? _attacker.choiceTrack], _attacker.choiceWep, wep_properties.strength)),
			factor : real(ds_grid_get(mWEP.wTracks[? _attacker.choiceTrack], _attacker.choiceWep, wep_properties.factor))
		}
	}
	else _choices[i] = script_execute(asset_get_index("act_" + _attacker.nextAction), _attacker);
}
//order attacks in priority queue
attackCount = 0;
attackQueue = ds_priority_create();
var _trackAmount = ds_list_size(mWEP.trackNames);
for (var i = 0; i < _trackAmount; ++i) {
	var _attackTrack = mWEP.trackNames[| i];
	//check current track index to see if an attacker is using that track, then add their attack to queue
	for (var c = 0; c < array_length(_choices); ++c) {
		if (_choices[c] == -1) {
			continue;
		}
		if (_choices[c].trackname = _attackTrack) {
			//priority number: track, weapon, order
			ds_priority_add(attackQueue, _choices[c], (i*1000) + (_choices[c].level * 10) + (ds_list_size(sourceRow) - c));
			++attackCount;
		}
	}
}
//begin attack sequence
comboScaled = array_create(ds_list_size(targetRow), comboBase)
alarm[0] = battleTick
activeAttack = ds_priority_find_min(attackQueue)