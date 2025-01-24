@tool
extends Node

@export var boba: Boba.Boba
@export var flavor: Flavors.Flavor
@export var ice_level: int
@export var topping: Toppings.Topping
@export var sweetness: int
@export var teabase: Teabase.Base
@export var whipped_cream: bool

@export var _test_boba: bool:
	set(value):
		construct_drink()
		_test_boba = false


@export var _is_on_cooldown: bool

@export var _cooldown_timer: float

signal drink_created(created_drink: bobaDrink)

func set_boba_type(boba_type: Boba.Boba):
	boba = boba_type

func set_flavor(flavor_type: Flavors.Flavor):
	flavor = flavor_type

func set_ice_level(set_ice: int):
	ice_level = set_ice

func set_topping_type(set_topping: Toppings.Topping):
	topping = set_topping

func set_sweetness_level(set_sweetness: int):
	sweetness = set_sweetness

func set_teebase_type(set_base: Teabase.Base):
	teabase = set_base

func set_whipped_cream(has_cream: bool):
	whipped_cream = has_cream

func construct_drink():
	
	if _is_on_cooldown == false:
		
		#creates new bobaDrink and sets its values
		var created_drink: bobaDrink = bobaDrink.new()
		
		#name and image need to be set
		created_drink.bubbles = boba
		created_drink.flavor = flavor
		created_drink.topping = topping
		created_drink.sweetness = sweetness
		created_drink.iceLevel = ice_level
		created_drink.hasWhippedCream = whipped_cream
		
		await _set_cooldown()
		
		drink_created.emit(created_drink)
		
		print(boba)
		print(flavor)
		print(topping)
		print(sweetness)
		print(ice_level)
		print(whipped_cream)
		print()
		
		#drink.new(boba, flavor, ice_level, topping, sweetness, teabase, whipped_cream)
		


func _set_cooldown():
	
	_is_on_cooldown = true
	await get_tree().create_timer(_cooldown_timer).timeout
	_is_on_cooldown = false
