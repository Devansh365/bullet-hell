extends Area2D

var direction : Vector2
var speed = 3
var is_hit = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if not is_hit:
		global_position += direction * speed

	await get_tree().create_timer(5.0).timeout
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("boss") and not is_hit:
		is_hit = true
		$Bullet2.visible = false 
		speed = 0 
		$GPUParticles2D.emitting = true
		Signalmanager.bullet2hitboss.emit()
		await get_tree().create_timer(1.0).timeout
		queue_free()
