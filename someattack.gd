extends Area2D
var direction : Vector2
var speed = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * speed
	rotation += TAU * delta  * 2
	await get_tree().create_timer(5.0).timeout
	queue_free()



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Signalmanager.playerspiralbullethit.emit()
		queue_free()
