extends Node

@export var _drink_constructor: DrinkConstructor

signal Create_drink()

func _ready() -> void:
	
	if _drink_constructor != null:
		Create_drink.connect(_drink_constructor.construct_drink)

func _on_button_down() -> void:
	
	Create_drink.emit()
