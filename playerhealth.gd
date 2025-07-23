extends TextureProgressBar
@export var player : CharacterBody2D

func _ready() -> void:
	if player:
		player.healthchanged.connect(update)
		update()


func _process(delta: float) -> void:
	pass
func update():
	value = player.player_health * 100/ player.max_health
