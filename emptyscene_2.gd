extends Node2D

const b = preload("res://boss fight.tscn")

@onready var label_2: Label = $Label2
@onready var label: Label = $CanvasLayer/playerhealth/Label

func _ready():
	start_boss_intro()
func start_boss_intro() -> void:
	await get_tree().create_timer(10).timeout
	label.visible = true
	label_2.visible = true
	await get_tree().create_timer(10).timeout

	get_tree().change_scene_to_packed(b)

	
