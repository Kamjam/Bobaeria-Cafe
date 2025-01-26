extends Node

# Load the custom images for the mouse cursor.
var hand_l = load("res://Hand3_light.png")
var hand_d = load("res://Hand3_dark.png")

func _ready():
	Input.set_custom_mouse_cursor(hand_l)
	TimeSys.time_system_updated.connect(_on_time_system_updated)


func _on_time_system_updated(date_time:DateTime):
	if date_time.hours >= 18:
		Input.set_custom_mouse_cursor(hand_d)
