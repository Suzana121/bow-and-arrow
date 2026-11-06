extends CanvasLayer

@onready var play_button = $ColorRect/MarginContainer/VBoxContainer/resume
@onready var quit_button = $ColorRect/MarginContainer/VBoxContainer/quit


func _ready() -> void:
	visible = false	
	play_button.pressed.connect(unpause)
	quit_button.pressed.connect(get_tree().quit)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			unpause()
		else:
			pause()
		get_viewport().set_input_as_handled()

func unpause():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	visible = false	

func pause():
	get_tree().paused = !get_tree().paused
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	visible = true
