extends Node2D
const father=preload("res://boss fight.tscn")
const b = preload("res://emptyscene2.tscn")
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_G:
				get_tree().change_scene_to_packed(father)
				# get_tree().change_scene_to_file("res://scenes/confront_father.tscn")
			KEY_H:
				get_tree().change_scene_to_packed(b)

							# get_tree().change_scene_to_file("res://scenes/get_bullets.tscn")
