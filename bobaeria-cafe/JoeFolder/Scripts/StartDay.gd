extends Node
var endDay

func _ready() -> void:
	endDay = get_tree().get_first_node_in_group("DayEnd")

func _on_button_down() -> void:
	endDay.StartNewDay()
	print("Pressed")
