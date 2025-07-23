extends Node2D

@export var speed := 50
@export var health := 3

@onready var character_body_2d = $CharacterBody2D
@onready var sprite_2d = $CharacterBody2D/Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CharacterBody2D/CollisionShape2D

var player: Node2D = null
var is_dead := false

func _ready():
	add_to_group("enemy")
	scale = Vector2(5,5)  

func _process(delta):
	if is_dead or player == null:
		return

	var direction = (player.global_position - global_position).normalized()
	character_body_2d.velocity = direction * speed
	character_body_2d.move_and_slide()

func take_damage():
	if is_dead:
		return

	health -= 1
	print("enemy dmg check1r", health) # didnt work idfacfdfgdf

	if health <= 0:
		die()

func die():
	is_dead = true
	queue_free()
