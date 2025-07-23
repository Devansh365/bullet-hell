extends Area2D

var direction : Vector2
var speed = 6
var is_hit = false

func _process(delta: float) -> void:
	if not is_hit:
		global_position += direction * speed

	await get_tree().create_timer(2.0).timeout
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if is_hit:
		return

	if body.is_in_group("enemy"):
		is_hit = true
		body.take_damage()
		queue_free()

	elif body.is_in_group("boss"):
		is_hit = true
		$Sprite2D.visible = false
		speed = 0
		$GPUParticles2D.emitting = true
		Signalmanager.bullet1hitboss.emit()
		await get_tree().create_timer(1.0).timeout
		queue_free()
