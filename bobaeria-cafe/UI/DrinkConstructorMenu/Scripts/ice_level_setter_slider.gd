extends Node

@export var _drink_constructor: DrinkConstructor

var _ice_level: int

signal Ice_Level_set(_ice_level: int)

func _ready() -> void:
	
	if _drink_constructor != null:
		Ice_Level_set.connect(_drink_constructor.set_ice_level)

#this is connected to the _on_value_changed event of the slider it is atached to
func _on_value_changed(value: float) -> void:
	_ice_level = value
	Ice_Level_set.emit(_ice_level)
