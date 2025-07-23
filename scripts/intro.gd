extends Node2D
const a =preload("res://scenes/menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	await play_fade_sequence()
	

func play_fade_sequence() -> void:
	$AnimationPlayer.play("fadein")
	await get_tree().create_timer(6).timeout
	$AnimationPlayer.play("fadeout")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_packed(a)
