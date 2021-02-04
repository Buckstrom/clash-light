// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function initialize_track(member,trackname,pres,level){
	if !(level > -1) { 
		level = ds_grid_width(mWEP.wTracks[? trackname]);
	}
	else {
		++level
	}
	ds_map_add(member.inventory, trackname, ds_grid_create(level, 4));
	ds_map_add(member.invPres, trackname, pres);
}