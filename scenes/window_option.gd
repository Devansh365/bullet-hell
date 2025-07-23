extends MarginContainer
@onready var option_button: OptionButton = $"volume indicator2/OptionButton"
const WINDOW_MODE_ARRAY: Array[String] = ["Full-Screen","Window Mode","Borderless Window","Borderless Full-Screen" 
]
 




func add_window_nodes():
	
	for window_note in WINDOW_MODE_ARRAY:
		option_button.add_item(window_note)
func _ready():
	add_window_nodes()
	
	option_button.item_selected.connect(on_window_mode_selected)
func on_window_mode_selected (index: int) -> void:
	match index:
		0: #Fullscreen
			DisplayServer.window_set_mode (DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag (DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1: #Window Mode
			DisplayServer.window_set_mode (DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag (DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2: #Borderless Window
			DisplayServer.window_set_mode (DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag (DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		3: #Borderless FullScreen
			DisplayServer.window_set_mode (DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag (DisplayServer.WINDOW_FLAG_BORDERLESS, true)

# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
