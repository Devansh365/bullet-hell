extends TextureProgressBar

@export var player : CharacterBody2D

func _ready():
	if player:
		player.manachanged.connect(update)
		update()

func update():
	value = player.mana * 100/ player.max_mana
