extends Node2D

var skeleton_scene = preload("res://skeleton.tscn")  # adjust if needed

@onready var player = $"../player"

func _ready():
	spawn_enemies()

func spawn_enemies():
	for i in range(3):
		var enemy = skeleton_scene.instantiate()
		add_child(enemy)
		enemy.global_position = global_position + Vector2(randi_range(-100, 100), randi_range(-100, 100))
		enemy.player = player
