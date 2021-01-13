// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function add_weapon(partymem, track, level, quantity){
	ds_grid_set(partymem.inventory[? track], level, 0, quantity)
}