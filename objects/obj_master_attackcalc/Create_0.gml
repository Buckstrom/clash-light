#macro mCALC obj_master_attackcalc

var _choices = ds_list_create();
//register weapon choices unordered
for (var i = 0; i < ds_list_size(mBATTLE.reg_party); ++i) {
	var _attacker = mBATTLE.reg_party[| i]
	_choices[| i] = {
		attacker : _attacker,
		trackname : _attacker.choiceTrack,
		level : _attacker.choiceWep,
		target : _attacker.choiceTarget,
		damage : real(ds_grid_get(mWEP.wTracks[? _attacker.choiceTrack], _attacker.choiceWep, 1))
	}
}
//order attacks in priority queue
attackCount = 0;
attackQueue = ds_priority_create();
for (var i = 0; i < ds_list_size(mWEP.trackNames); ++i) {
	var _attackTrack = mWEP.trackNames[| i];
	//check current track index to see if an attacker is using that track, then add their attack to queue
	for (var c = 0; c < ds_list_size(_choices); ++c) {
		if (_choices[| c].trackname = _attackTrack) {
			//priority number: track, weapon, order
			ds_priority_add(attackQueue, _choices[| c], (i*1000) + (_choices[| c].level * 10) + (ds_list_size(mBATTLE.reg_party) - c));
			++attackCount;
		}
	}
}
ds_list_destroy(_choices);
//begin attack sequence
comboScaled = array_create(ds_list_size(mBATTLE.reg_enemy), comboBase)
alarm[0] = battleTick
activeAttack = ds_priority_find_min(attackQueue)