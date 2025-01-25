extends Node

@export var _drink_constructor: DrinkConstructor

@export var _tea_base_type: Teabase.Base

signal tea_base_selected(base_type)

func _ready() -> void:
	
	if _drink_constructor != null:
		tea_base_selected.connect(_drink_constructor.set_teebase_type)

#this is connected to the toggled event of the button it is atached to
func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		tea_base_selected.emit(_tea_base_type)
