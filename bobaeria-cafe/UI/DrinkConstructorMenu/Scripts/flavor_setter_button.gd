extends Node

@export var _drink_constructor: DrinkConstructor

@export var _flavor_type: Flavors.Flavor

signal flavor_selected(_flavor_type)

func _ready() -> void:
	
	if _drink_constructor != null:
		flavor_selected.connect(_drink_constructor.set_flavor)

#this is connected to the toggled event of the button it is atached to
func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		flavor_selected.emit(_flavor_type)
