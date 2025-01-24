class_name drink
extends Node

var boba: 
var flavors: Flavors.Flavor
var ice_level: int
var topping: Toppings.Topping
var sweetness: int
var teabase: Teabase.Base
var whipped_cream: bool

func _init(boba_type: Boba.Boba, flavor_type: Flavors.Flavor, ice_type: int, 
topping_type: Toppings.Topping, sweetness_type: int, base_type:Teabase.Base,
cream_type: bool) -> void:
	boba = boba_type
	flavors = flavor_type
	ice_level = ice_type
	topping = topping_type
	sweetness = sweetness_type
	teabase = base_type
	whipped_cream = cream_type
