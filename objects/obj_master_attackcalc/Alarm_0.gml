/// @description Perform next attack
++attackNum
if (!(attackNum < attackCount)) {
	mBATTLE.currentState = battleState.e_attack
	instance_destroy(self)
	return;
}
var _activeAttack = ds_priority_delete_min(attackQueue)
//perform attack
script_execute(mWEP.trackScripts[? _activeAttack.trackname], _activeAttack);
//remove intent from partymem
clear_target(_activeAttack.attacker);
//check if the next weapon is a different track or if the current weapon is the last attack
var _calcBonus = false;
switch (ds_priority_size(attackQueue)) {
	case 0:
	_calcBonus = true;
	break;
	default:
	_calcBonus = _activeAttack.trackname != ds_priority_find_min(attackQueue).trackname;
	break
}
if (_calcBonus) {
	for (var i = 0; i < ds_list_size(mBATTLE.reg_enemy); ++i) {
		var _enemy = mBATTLE.reg_enemy[| i]
		//deal combo damage
		if (_enemy.comboCount > 1) {
			_enemy.currentHP -= ceil((_enemy.damageSum) * comboScaled[i])
		}
		//deal lure damage
		if (useLureKB && ds_map_exists(_enemy.debuffs, "lured") && _enemy.damageSum > 0) {
			var _lureFactor = array_get(ds_map_find_value(_enemy.debuffs, "lured"), debuff_properties.factor);
			_enemy.currentHP -= ceil((_enemy.damageSum) * _lureFactor)
			ds_map_delete(_enemy.debuffs, "lured")
		}
		//reset per-track damage intake
		resetCombo(_enemy);
		comboScaled[i] = comboBase;
	}
}
//Loop
alarm[0] = battleTick;