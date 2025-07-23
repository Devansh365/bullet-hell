class_name SettingsMenu extends Control
var menu= preload("res://scenes/menu.tscn")
@onready var button: Button = $MarginContainer/VBoxContainer/Button
signal exit_options_menu
@onready var exit_for_1: Button = $"MarginContainer/CanvasLayer/TabContainer/Sounds and Graphics/VBoxContainer/resoltuion option/volume indicator2/OptionButton/exit for1"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.button_down.connect(on_exit_pressed)
	
func on_exit_pressed():
	get_tree().change_scene_to_packed(menu)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(menu)
