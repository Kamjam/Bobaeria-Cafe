extends Node

# Load the custom images for the mouse cursor.
var hand_l = load("res://Icons/Hand3_light.png")
var hand_d = load("res://Icons/Hand3_dark.png")

func _ready():
	Input.set_custom_mouse_cursor(hand_l, Input.CURSOR_ARROW, Vector2(16, 16))
	TimeSys.time_system_updated.connect(_on_time_system_updated)

#func _process(delta: float) -> void:
	#Input.set_custom_mouse_cursor(hand_l, Input.CURSOR_ARROW, Vector2(16, 16))

func _on_time_system_updated(date_time:DateTime):
	if date_time.hours >= 18:
		Input.set_custom_mouse_cursor(hand_d, Input.CURSOR_ARROW, Vector2(16, 16))
