extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var health = 350
var max_health = 350

signal healthchanged


@onready var bullethole_2: Node2D = $Node/bullethole2
@onready var bullethole = $bullethole
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var halfhealthboss = 0
var spiralattack = 0
var is_dead = false

var enemybullet = preload("res://enemybullet.tscn")
var bullet_scene = preload("res://enemybulletspiral.tscn")
var somebullet = preload("res://someattack.tscn")

@export var spiral_fire_rate := 0.1
@export var spiral_rot_speed := 2.0
@export var spiral_speed := 1.0
var spiral_angle := 3.0

var heal_timer : Timer
var shoot_timer : Timer
var someattack : Timer
var spiral_timer : Timer
var halfhealth_timer_on : Timer
var halfhealth_timer_off : Timer
var spiral_timer_on : Timer
var spiral_timer_off : Timer

func _ready() -> void:
	animation_player.play("spiralnode")
	animation_player.play("blink")

	Signalmanager.bullet1hitboss.connect(bullet1)
	Signalmanager.bullet2hitboss.connect(bullet2)
	Signalmanager.bullet3hitboss.connect(bullet3)

	spiral_timer = Timer.new()
	spiral_timer.wait_time = spiral_fire_rate
	spiral_timer.one_shot = false
	spiral_timer.autostart = true
	spiral_timer.timeout.connect(_on_spiral_timer_timeout)
	add_child(spiral_timer)

	halfhealth_timer_on = Timer.new()
	halfhealth_timer_on.wait_time = 10.0
	halfhealth_timer_on.one_shot = false
	halfhealth_timer_on.autostart = true
	halfhealth_timer_on.timeout.connect(_start_halfhealthboss)
	add_child(halfhealth_timer_on)

	halfhealth_timer_off = Timer.new()
	halfhealth_timer_off.wait_time = 5.0
	halfhealth_timer_off.one_shot = true
	halfhealth_timer_off.timeout.connect(_stop_halfhealthboss)
	add_child(halfhealth_timer_off)

	spiral_timer_on = Timer.new()
	spiral_timer_on.wait_time = 15.0
	spiral_timer_on.one_shot = false
	spiral_timer_on.autostart = true
	spiral_timer_on.timeout.connect(_start_spiral_attack)
	add_child(spiral_timer_on)

	spiral_timer_off = Timer.new()
	spiral_timer_off.wait_time = 5.0
	spiral_timer_off.one_shot = true
	spiral_timer_off.timeout.connect(_stop_spiral_attack)
	add_child(spiral_timer_off)

	heal_timer = Timer.new()
	heal_timer.wait_time = 1.0
	heal_timer.one_shot = false
	heal_timer.autostart = true
	heal_timer.timeout.connect(heal)
	add_child(heal_timer)

	shoot_timer = Timer.new()
	shoot_timer.wait_time = 0.25
	shoot_timer.one_shot = false
	shoot_timer.autostart = true
	shoot_timer.timeout.connect(shoot1)
	add_child(shoot_timer)

	someattack = Timer.new()
	someattack.wait_time = 0.05
	someattack.one_shot = false
	someattack.autostart = true
	someattack.timeout.connect(someattackdone)
	add_child(someattack)

func _physics_process(delta: float) -> void:
	if health <= 0 and not is_dead:
		is_dead = true

		# Emit death particles
		$GPUParticles2D.emitting = true

		# Hide everything
		$Node.visible = false
		$bullethole.visible = false
		$Node/bullethole2.visible = false
		$AnimationPlayer.stop()

		# Stop all timers
		shoot_timer.stop()
		heal_timer.stop()
		someattack.stop()
		spiral_timer.stop()
		halfhealth_timer_on.stop()
		halfhealth_timer_off.stop()
		spiral_timer_on.stop()
		spiral_timer_off.stop()

		# Disable further physics processing
		set_physics_process(false)

		await get_tree().create_timer(2.0).timeout
		Signalmanager.bossdead.emit()

	healthchanged.emit()

func bullet1():
	if is_dead:
		return
	health -= 5
	health = clamp(health, 0, max_health)
	$AudioStreamPlayer.play()

func bullet2():
	if is_dead:
		return
	health -= 20
	health = clamp(health, 0, max_health)
	$AudioStreamPlayer.play()

func bullet3():
	if is_dead:
		return
	health -= 40
	health = clamp(health, 0, max_health)
	$AudioStreamPlayer.play()

func heal():
	if health < max_health:
		health += 1
		health = min(health, max_health)

func shoot1():
	var shoot1 = enemybullet.instantiate()
	shoot1.global_position = bullethole.global_position
	shoot1.direction = (player.global_position - global_position).normalized()
	$/root/main.add_child(shoot1)

func _on_spiral_timer_timeout():
	if spiralattack == 1:
		spiral_angle += spiral_rot_speed
		var dir = Vector2(cos(spiral_angle), sin(spiral_angle))
		var b = bullet_scene.instantiate()
		b.global_position = bullethole_2.global_position
		b.direction = dir
		b.speed = spiral_speed
		get_tree().root.add_child(b)

func someattackdone():
	if halfhealthboss == 1:
		var shoot12 = somebullet.instantiate()
		shoot12.global_position = bullethole.global_position
		shoot12.direction = (player.global_position - global_position).normalized()
		$/root/main.add_child(shoot12)

func _start_halfhealthboss():
	halfhealthboss = 1
	halfhealth_timer_off.start()

func _stop_halfhealthboss():
	halfhealthboss = 0

func _start_spiral_attack():
	spiralattack = 1
	spiral_timer_off.start()

func _stop_spiral_attack():
	spiralattack = 0
