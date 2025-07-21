extends TextureProgressBar
@export var boss : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	boss.healthchanged.connect(update)
	update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func update():
	value = boss.health * 100/ boss.max_health
