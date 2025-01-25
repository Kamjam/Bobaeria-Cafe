extends Node

@export var _drink_constructor: DrinkConstructor

signal Whipped_cream_set(has_whipped_cream: bool)

func _ready() -> void:
	
	if _drink_constructor != null:
		Whipped_cream_set.connect(_drink_constructor.set_whipped_cream)

func _on_toggled(toggled_on: bool) -> void:
	Whipped_cream_set.emit(toggled_on)
