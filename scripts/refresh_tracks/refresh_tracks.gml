// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function refresh_tracks(member){
	ds_list_clear(member.ownedtracks)
	var _n = 0;
	for (var t = 0; t < ds_list_size(mWEP.trackNames); ++t) {
		//check each track
		var _readTrack = mWEP.trackNames[| t];
		//if member owns a track, add to list
		if (ds_map_exists(member.inventory, _readTrack)) {
			member.ownedtracks[| _n++] = _readTrack;
		}
	}
}