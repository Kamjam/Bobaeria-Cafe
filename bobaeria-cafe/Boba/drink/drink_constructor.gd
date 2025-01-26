@tool
class_name  DrinkConstructor
extends Node

@export var boba_level: int
@export var flavor: Flavors.Flavor
@export var ice_level: int
@export var topping: Toppings.Topping
@export var sweetness: int
@export var teabase: Teabase.Base
@export var whipped_cream: bool

@export var _number_of_drinks_to_construct: int = 1

@export var _test_boba: bool:
	set(value):
		construct_drink()
		_test_boba = false


@export var _is_on_cooldown: bool

@export var _cooldown_timer: float
var isShowing = false

signal drink_created(created_drink: bobaDrink)

func set_boba_level(set_level: int):
	boba_level = set_level

func set_flavor(flavor_type: Flavors.Flavor):
	flavor = flavor_type

func set_ice_level(set_ice: int):
	ice_level = set_ice

func set_topping_type(set_topping: Toppings.Topping):
	topping = set_topping

func set_sweetness_level(set_sweetness: int):
	sweetness = set_sweetness
	print(sweetness)

func set_teebase_type(set_base: Teabase.Base):
	teabase = set_base
	print(teabase)

func set_whipped_cream(has_cream: bool):
	whipped_cream = has_cream

func update_drink_count(updated_drink_count: int):
	_number_of_drinks_to_construct = updated_drink_count

func construct_drink():
	
	if _is_on_cooldown == false:
		
		#creates new bobaDrink and sets its values
		var created_drink: bobaDrink = bobaDrink.new()
		
		#name and image need to be set
		created_drink.teaBase = teabase
		created_drink.bubbleLevel = boba_level
		created_drink.flavor = flavor
		created_drink.topping = topping
		created_drink.sweetness = sweetness
		created_drink.iceLevel = ice_level
		created_drink.hasWhippedCream = whipped_cream
		
		#waits for cooldown to finish befor emiting drink signal
		await _set_cooldown()
		
		for int in _number_of_drinks_to_construct:
			drink_created.emit(created_drink)
			
			print(created_drink.teaBase)
			print(created_drink.bubbleLevel)
			print(created_drink.flavor)
			print(created_drink.topping)
			print(created_drink.sweetness)
			print(created_drink.iceLevel)
			print(created_drink.hasWhippedCream)
			
		
		#drink.new(boba, flavor, ice_level, topping, sweetness, teabase, whipped_cream)

#enables _is_on_cooldown and disables it after the timer finishes
func _set_cooldown():
	
	_is_on_cooldown = true
	await get_tree().create_timer(_cooldown_timer).timeout
	_is_on_cooldown = false


#dev tool
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_text_backspace"):
		isShowing = !isShowing
		if isShowing:
			$".".show()
		else:
			$".".hide()
			
