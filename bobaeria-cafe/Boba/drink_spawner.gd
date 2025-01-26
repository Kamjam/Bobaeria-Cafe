class_name DrinkSpawner
extends Node
@export var _time_till_drink_despawn: float = 4

@export var _drink_fall_speed: float = 1

@export var _drink_prefab: PackedScene

var _drink_spawn_dict: Dictionary = {}

@export var _drink_spawn_points: Array[Node3D]

@export var _drink_constructor: DrinkConstructor

var _return_queue: Array[Node3D]

@export var _player: Player

var dayEnd

signal drink_spawned(spawned_drink: Node3D)

signal destroy_drink(drink: Node3D)

func _ready() -> void:
	dayEnd = get_tree().get_first_node_in_group("DayEnd")
	if _drink_constructor != null:
		_drink_constructor.drink_created.connect(_spawn_drink)
	
	if _player != null:
		_player.DrinkPickedUp.connect(_remove_drink_from_destroy_queue)
	
	for points in _drink_spawn_points:
		_drink_spawn_dict[points] = null

func _process(delta: float) -> void:
	_return_drinks_to_spawn(delta)

func _spawn_drink(drink_to_spawn: bobaDrink):
	
	for point in _drink_spawn_points:
		if _drink_spawn_dict[point] == null:
			var spawned_tea: Tea = _drink_prefab.instantiate()
			point.add_child(spawned_tea)
			
			spawned_tea.global_position = point.global_position
			spawned_tea.set_drink_instance(drink_to_spawn)
			
			_drink_spawn_dict[point] = spawned_tea
			drink_spawned.emit(spawned_tea)
			if dayEnd:
				dayEnd.SetMade()
			_add_drink_to_destroy_queue(spawned_tea)
			#stops looking for empty spawn point if one is found
			return

func _add_drink_to_destroy_queue(added_drink: Node3D):
	
	await get_tree().create_timer(_time_till_drink_despawn).timeout
	
	for nodes in _drink_spawn_points:
		if _drink_spawn_dict[nodes] == added_drink:
			
			destroy_drink.emit(added_drink) 

func _remove_drink_from_destroy_queue(removed_drink: Node3D):
	
	for points in _drink_spawn_points:
		if _drink_spawn_dict[points] == removed_drink:
			
			_drink_spawn_dict[points] = null

func add_drink_to_return_queue(drink: Node3D, drink_position: Vector3):
	
	var global_pos: Vector3 = drink.global_position
	
	print("drink to add to queue is: ", drink)
	print(drink.global_position)
	for nodes in _drink_spawn_points:
		if _drink_spawn_dict[nodes] == drink:
			nodes.add_child(drink)
			
	
	drink.global_position = drink_position
	drink.scale = Vector3(0.25, 0.25, 0.25)
	
	print("drink has been reparented")
	print(drink.global_position)
	_return_queue.append(drink)
	
	
	
	print(drink, "has been added to the que")

func _return_drinks_to_spawn(delta: float):
	
	if _return_queue.size() > 0:
		
		for nodes in _drink_spawn_points:
		
			for drinks in _return_queue:
				
				if drinks == _drink_spawn_dict[nodes] and drinks != null:
					
					drinks.global_position = lerp(drinks.global_position, nodes.global_position, _drink_fall_speed * delta)
					
					print("distance is: ", drinks.global_position.distance_to(nodes.global_position))
					
					if drinks.global_position.distance_to(nodes.global_position) < 0.01:
						
						print("distance is: ", drinks.global_position.distance_to(nodes.global_position))
						drinks.global_position = nodes.global_position
						
						_remove_drink_from_return_queue(drinks)
						_add_drink_to_destroy_queue(drinks)
		

func _remove_drink_from_return_queue(removed_drink: Node3D):
	
	if(_return_queue.has(removed_drink)):
		_return_queue.erase(removed_drink)
