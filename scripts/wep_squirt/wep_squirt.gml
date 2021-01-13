// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wep_squirt(attack){
	useLureKB = true;
	damage_target(attack, 0.2);
	debuff_target(attack, "soaked", 1, 0, 0)
}