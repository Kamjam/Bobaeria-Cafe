extends Node

@export var _drink_constructor: DrinkConstructor

var _boba_level: int

signal Boba_Level_set(boba_leve: int)

func _ready() -> void:
	
	if _drink_constructor != null:
		Boba_Level_set.connect(_drink_constructor.set_boba_level)

#this is connected to the _on_value_changed event of the slider it is atached to
func _on_value_changed(value: float) -> void:
	_boba_level = value
	Boba_Level_set.emit(_boba_level)
