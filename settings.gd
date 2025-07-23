extends Control
@onready var exit: Button = $MarginContainer/VBoxContainer/exit
const menus1= preload("res://scenes/menu.tscn")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		
		
#

func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value/5)




		
		




func _on_button_2_button_down() -> void:
	AudioServer.set_bus_mute(1,false) # Replace with function body.


func _on_button_button_down() -> void:
	AudioServer.set_bus_mute(2,true)


func _on_button_2_pressed() -> void:
	pass # Replace with function body.


func _on_exitfortab_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_exitfortab_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_exit_for_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
