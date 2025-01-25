extends Node

@export var _drink_constructor: DrinkConstructor

@export var _topping_type: Toppings.Topping

signal topping_selected(base_type)

func _ready() -> void:
	
	if _drink_constructor != null:
		topping_selected.connect(_drink_constructor.set_topping_type)

#this is connected to the toggled event of the button it is atached to
func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		topping_selected.emit(_topping_type)
