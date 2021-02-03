// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function refresh_tracks(member, hasPrestige){
	ds_map_clear(member.ownedtracks)
	var _trackNames = mWEP.trackNames
	for (var t = 0; t < ds_list_size(_trackNames); ++t) {
		//check each track
		var _readTrack = _trackNames[| t];
		//if member owns a track, add to list
		if (ds_map_exists(member.inventory, _readTrack)) {
			ds_map_add(member.ownedtracks, _readTrack, hasPrestige);
		}
	}
}