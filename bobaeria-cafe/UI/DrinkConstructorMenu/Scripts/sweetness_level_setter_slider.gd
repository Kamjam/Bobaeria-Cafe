extends Node

@export var _drink_constructor: DrinkConstructor

var _sweetness_level: int

signal Sweetness_Level_set(sweetness_level: int)

func _ready() -> void:
	
	if _drink_constructor != null:
		Sweetness_Level_set.connect(_drink_constructor.set_sweetness_level)

#this is connected to the _on_value_changed event of the slider it is atached to
func _on_value_changed(value: float) -> void:
	_sweetness_level = value
	Sweetness_Level_set.emit(_sweetness_level)
