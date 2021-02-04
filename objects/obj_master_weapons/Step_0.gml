if (editSprite > -1) {
	global.use_sprites = editSprite.editValue
}
else {
	editSprite = instance_create_layer(32, 480, self.layer, button_adjust_bool)
	editSprite.label = "Use Sprites"
	editSprite.editValue = global.use_sprites
}