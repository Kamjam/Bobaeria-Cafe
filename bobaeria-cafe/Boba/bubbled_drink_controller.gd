extends Node

@export var _bubble_float_hight: float

@export var _bubble_durration_time: float

@export var _drink_bubble: PackedScene

@export var _drink_spawner: DrinkSpawner

@export var _time_till_despawn_start: float = 5

var _pending_queue_list: Array[Node3D]

var _bubbled_drinks: Array[Node3D]

func _ready() -> void:
	
	if(_drink_spawner != null):
		_drink_spawner.destroy_drink.connect(_bubble_new_drink)

func _bubble_new_drink(new_drink: Node3D):
	
	var bubble: DrinkBubble = _drink_bubble.instantiate()
	new_drink.get_parent().add_child(bubble)
	bubble.set_bubble_stats(_bubble_float_hight, _bubble_durration_time)
	new_drink.reparent(bubble)
	#bubble.add_drink_to_bubble(new_drink)
	bubble.bubble_popped.connect(_return_drink_to_spawner)

func remove_drink_from_bubbled_drinks(removed_drink: Node3D):
	
	_bubbled_drinks.erase(removed_drink)

#func _despawn_drink(drink: Node3D):
	#
#
#func _process(delta: float) -> void:
	#for

func _return_drink_to_spawner(drink: Node3D):
	_drink_spawner.add_drink_to_return_queue(drink)
