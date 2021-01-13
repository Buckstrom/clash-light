// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_lure(attack){
	useLureKB = false;
	debuff_target(attack, "lured", attack.damage, 0.5, 0);
}