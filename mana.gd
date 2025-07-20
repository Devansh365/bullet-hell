extends TextureProgressBar
@export var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.manachanged.connect(update)
	update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func update():
	value = player.mana * 100/ player.max_mana
