extends Area2D
var direction : Vector2
var speed = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * speed
	await get_tree().create_timer(0.5).timeout
	queue_free()
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("boss"):
		Signalmanager.bullet3hitboss.emit()
		queue_free()
