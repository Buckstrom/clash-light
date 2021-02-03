// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function battle_check_ready(){
	var _ready = false;
	//change active party member to the next undecided one, otherwise move to anim
	var _partySize = ds_list_size(mBATTLE.reg_party)
	var _currentMem = mBATTLE.current_partymem
	for (var _partyDecided = 0; _partyDecided < _partySize; ++_partyDecided) {
		//stop at a member that is undecided
		if (mBATTLE.reg_party[| _currentMem].nextAction == false) {
			break;
		}
		//otherwise, check the next
		if (_currentMem < _partySize - 1) {
			++_currentMem
		}
		else {
			_currentMem = 0;
		}
	}
	mBATTLE.current_partymem = _currentMem
	if (_partyDecided == _partySize) {
		mBATTLE.currentState = battleState.p_attack;
		_ready = true;
	}
	return _ready;
}