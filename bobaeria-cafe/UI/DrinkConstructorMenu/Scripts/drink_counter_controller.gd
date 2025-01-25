class_name DrinkCounterController
extends Node

var _drink_counter: int = 1

@export var _drink_constructor: DrinkConstructor

@export var _counter_label: Label

@export var _less_button: Button

@export var _more_button: Button

signal DrinkCountUpdated(drink_count: int)

func _ready() -> void:
	
	if _drink_constructor != null:
		DrinkCountUpdated.connect(_drink_constructor.update_drink_count)
	
	_update_drink_counter()
	_less_button.button_down.connect(_decrease_drink_count)
	_more_button.button_down.connect(_increase_drink_count)

func _increase_drink_count():
	
	_drink_counter += 1
	_update_drink_counter()

func _decrease_drink_count():
	
	if _drink_counter > 1:
		_drink_counter -= 1
		_update_drink_counter()

func _update_drink_counter():
	
	_counter_label.text = str(_drink_counter)
	DrinkCountUpdated.emit(_drink_counter)
