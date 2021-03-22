if (editSprite > -1) {
	global.use_sprites = editSprite.editValue
}
else {
	editSprite = instance_create_layer(32, 480, self.layer, button_adjust_bool)
	editSprite.label = "Use Sprites"
	editSprite.editValue = global.use_sprites
}
if (editBattleTick > -1) {
	global.battle_tick = editBattleTick.editValue
}
else {
	editBattleTick = instance_create_layer(96, 400, self.layer, button_adjust_integer)
	editBattleTick.label = "Action Time"
	editBattleTick.editValue = global.battle_tick
}