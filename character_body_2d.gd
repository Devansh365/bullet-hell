extends CharacterBody2D

@export var speed = 400
var bullet_scene = preload("res://bullet1.tscn")
var bullet_scene3 = preload("res://bullet3.tscn")
var bullet_scene2 = preload("res://bullet_2.tscn")
var weapon = 1

const SPEED = 400.0
signal healthchanged
@onready var gun = $gun
@onready var bullethole = $bullethole
var max_mana = 150
signal manachanged
var mana = 150
var mana_regen_timer := 0.0
var player_health = 100
var max_health = 100
func _ready() -> void:
	Signalmanager.playerbullet1hit.connect(playerbullet1hit)
	Signalmanager.playerspiralbullethit.connect(playerspiralbullethit)
	var heal_timer = Timer.new()
	heal_timer.wait_time = 0.2
	heal_timer.one_shot = false
	heal_timer.autostart = true
	add_child(heal_timer)
	heal_timer.timeout.connect(_on_heal_timer_timeout)

func _physics_process(delta: float) -> void:
	healthchanged.emit()
	manachanged.emit()
	if player_health <= 0:
		get_tree().reload_current_scene()

	look_at(get_global_mouse_position())


	velocity.x = Input.get_axis("left", "right") * SPEED
	velocity.y = Input.get_axis("up", "down") * SPEED
	velocity = lerp(get_real_velocity(), velocity, 0.1)
	move_and_slide()

	if Input.is_action_just_pressed("shoot"):
		if weapon == 1:
			if mana >= 20:
				var bullet = bullet_scene.instantiate()
				bullet.global_position = bullethole.global_position
				bullet.direction = (get_global_mouse_position() - global_position).normalized()
				$/root/main.add_child(bullet)
				mana -= 20
				
		if weapon == 2:
			if mana >= 20:
				var bullet2 = bullet_scene2.instantiate()
				bullet2.global_position = bullethole.global_position
				bullet2.direction = (get_global_mouse_position() - global_position).normalized()
				$/root/main.add_child(bullet2)
				mana -= 20
		if weapon == 3:
			if mana >= 20:
				var bullet3 = bullet_scene3.instantiate()
				bullet3.global_position = bullethole.global_position
				bullet3.direction = (get_global_mouse_position() - global_position).normalized()
				$/root/main.add_child(bullet3)
				mana -= 20
	

	mana_regen_timer += delta
	if mana < max_mana and mana_regen_timer >= 0.1:
		mana += 1
		mana_regen_timer = 0.0
		
	if Input.is_action_just_pressed("1"):
		weapon = 1
	if Input.is_action_pressed("2"):
		weapon = 2
	if Input.is_action_pressed("3"):
		weapon = 3

	# Clamp mana to max 100
	mana = clamp(mana, 0, max_mana)
	player_health = clamp(player_health, 0, max_health)
	
func playerbullet1hit():
	player_health = player_health - 10
func playerspiralbullethit():
	player_health = player_health - 2
func _on_heal_timer_timeout() -> void:
	if player_health < max_health:
		player_health = min(player_health + 1, max_health)
		emit_signal("healthchanged")
