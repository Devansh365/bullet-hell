extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signalmanager.bossdead.connect(bossdead)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func bossdead():
	$CanvasLayer/AnimationPlayer.play("afterdeathboss")
	await get_tree().create_timer(4.0).timeout
	get_tree().quit()
