// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function battle_check_ready(){
	//change active party member to the next undecided one, otherwise move to anim
	for (var _partyDecided = 0; _partyDecided < ds_list_size(reg_party); ++_partyDecided) {
		//stop at a member that is undecided
		if (mCURRENT_MEM.nextAction == false) {
			break;
		}
		//otherwise, check the next
		if (current_partymem < ds_list_size(reg_party) - 1) {
			++current_partymem
		}
		else {
			current_partymem = 0;
		}
	}
	if (_partyDecided == ds_list_size(reg_party)) {
		currentState = battleState.p_attack;
	}
}