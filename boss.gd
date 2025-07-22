extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player") as CharacterBody2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var health = 150
var max_health = 150
signal healthchanged
@onready var bullethole_2: Node2D = $bullethole2
var halfhealthboss = 0

var enemybullet = preload("res://enemybullet.tscn")
var bullet_scene = preload("res://enemybulletspiral.tscn")
var somebullet = preload("res://someattack.tscn")
@onready var bullethole = $bullethole
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var heal_timer : Timer
var shoot_timer : Timer
var someattack : Timer

@export var spiral_fire_rate := 0.1   # seconds between bullets
@export var spiral_rot_speed := 2.0    # radians per bullet
@export var spiral_speed := 1.0     # bullet speed

var spiral_angle := 3.0
var spiral_timer: Timer

func _ready() -> void:
	animation_player.play("spiralnode")
	# Connect bullet hit signals
	Signalmanager.bullet1hitboss.connect(bullet1)
	Signalmanager.bullet2hitboss.connect(bullet2)
	Signalmanager.bullet3hitboss.connect(bullet3)
	
	
	spiral_timer = Timer.new()
	spiral_timer.wait_time = spiral_fire_rate
	spiral_timer.one_shot = false
	spiral_timer.autostart = true
	add_child(spiral_timer)
	
	
	spiral_timer.timeout.connect(_on_spiral_timer_timeout)
	# Healing Timer
	heal_timer = Timer.new()
	heal_timer.wait_time = 1.0
	heal_timer.one_shot = false
	heal_timer.autostart = true
	add_child(heal_timer)
	heal_timer.timeout.connect(heal)
	
	someattack = Timer.new()
	someattack.wait_time = 0.05
	someattack.one_shot = false
	someattack.autostart = true
	add_child(someattack)
	someattack.timeout.connect(someattackdone)
	

	# Shooting Timer
	shoot_timer = Timer.new()
	shoot_timer.wait_time = 0.25
	shoot_timer.one_shot = false
	shoot_timer.autostart = true
	add_child(shoot_timer)
	shoot_timer.timeout.connect(shoot1)

func _physics_process(delta: float) -> void:
	if health == 0:
		queue_free()
	healthchanged.emit()
	if health <= max_health/5:
		halfhealthboss = 1
		
	

func bullet1():
	health -= 10
	health = clamp(health, 0, max_health)

func bullet2():
	health -= 50
	health = clamp(health, 0, max_health)

func bullet3():
	health -= 100
	health = clamp(health, 0, max_health)

func heal():
	if health < max_health:
		health += 5
		health = min(health, max_health)

func shoot1():
	var shoot1 = enemybullet.instantiate()
	shoot1.global_position = bullethole.global_position
	shoot1.direction = (player.global_position - global_position).normalized()
	$/root/main.add_child(shoot1)

func _on_spiral_timer_timeout():
	spiral_angle += spiral_rot_speed
	var dir = Vector2(cos(spiral_angle), sin(spiral_angle))
	var b = bullet_scene.instantiate()
	b.global_position = bullethole_2.global_position
	b.direction = dir
	b.speed = spiral_speed
	get_tree().root.add_child(b)
	
func someattackdone():
	if halfhealthboss == 1:
		print(halfhealthboss)
		var shoot12 = somebullet.instantiate()
		shoot12.global_position = bullethole.global_position
		shoot12.direction = (player.global_position - global_position).normalized()
		$/root/main.add_child(shoot12)

	

	
