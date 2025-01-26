class_name DrinkBubble
extends Node3D

var _drink: Node3D

var _bubble_float_speed: float

var _popping_hight: float 

var _bubble_duration: float

var _stats_set: bool = false

var _current_hight: float

var dayEnd

signal bubble_popped(drink_node: Node3D, bubble_pos: Vector3)
func _ready() -> void:
	dayEnd = get_tree().get_first_node_in_group("DayEnd")
func set_bubble_stats(popping_hight: float, time_till_bubble_pop:float):
	
	_bubble_float_speed = popping_hight / time_till_bubble_pop
	
	_popping_hight = popping_hight
	
	_stats_set = true

func add_drink_to_bubble(drink: Node3D):
	#drink.reparent(drink)
	#drink.global_position = self.global_position
	_drink = drink

func _process(delta: float) -> void:
	
	if _stats_set :
		
		if(_current_hight >= _popping_hight):
			if dayEnd:
				dayEnd.SetBubbled()
			self.queue_free()
		
		else:
			_current_hight += _bubble_float_speed * delta
			position.y += _bubble_float_speed * delta

func pop_bubble():
	
	print("bubble is popped")
	remove_child(_drink)
	_drink.global_position = self.global_position
	print("bubble is popped")
	bubble_popped.emit(_drink, self.global_position)
	self.queue_free()
