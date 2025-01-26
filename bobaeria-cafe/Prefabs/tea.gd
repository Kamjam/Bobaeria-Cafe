class_name Tea
extends Area3D

var selected = false
var player

@export var _drink_resource: bobaDrink = bobaDrink.new()

func set_drink_instance(set_drink: bobaDrink):
	_drink_resource = set_drink
	


#func _ready() -> void:
	#player = get_tree().get_first_node_in_group("player")
	##player.interact_object.connect(_set_selected)
