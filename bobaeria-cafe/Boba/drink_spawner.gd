extends Node

@export var _drink_prefab: PackedScene

var _drink_spawn_dict: Dictionary = {}

@export var _drink_spawn_points: Array[Node3D]

@export var _drink_constructor: DrinkConstructor

signal drink_spawned(spawned_drink: Node3D)

func _ready() -> void:
	pass
	if _drink_constructor != null:
		_drink_constructor.drink_created.connect(_spawn_drink)
	
	for points in _drink_spawn_points:
		_drink_spawn_dict[points] = null

func _spawn_drink(drink_to_spawn: bobaDrink):
	
	for point in _drink_spawn_points:
		if _drink_spawn_dict[point] == null:
			var spawned_tea: Tea = _drink_prefab.instantiate()
			point.add_child(spawned_tea)
			
			spawned_tea.global_position = point.global_position
			spawned_tea.set_drink_instance(drink_to_spawn)
			
			_drink_spawn_dict[point] = spawned_tea
			drink_spawned.emit(spawned_tea)
			
			#stops looking for empty spawn point if one is found
			return
