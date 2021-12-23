// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_wep_sprite(trackname){
	var _assetName = "spr_" + trackname + "_ttcc"
	return (asset_get_index(_assetName))
}