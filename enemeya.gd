extends CharacterBody2D

@onready var character_body_2d: CharacterBody2D = $CharacterBody2D
@onready var collision_shape_2d: CollisionShape2D = $CharacterBody2D/CollisionShape2D
@onready var sprite_2d: Sprite2D = $CharacterBody2D/Sprite2D

@export var speed := 50
@export var health := 1
var player: Node2D

func _physics_process(_delta):
	if not player:
		return
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func take_damage():
	health -= 1
	if health <= 0:
		queue_free()

func _on_area_entered(area: Area2D):
	if area.name == "Bullet":  
		take_damage()
	if area.name == "Player":
		queue_free()
