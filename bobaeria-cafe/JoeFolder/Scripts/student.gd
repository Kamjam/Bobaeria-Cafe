class_name Student
extends CharacterBody3D

@export var agent : NavigationAgent3D
@export var stoppingDistance : float = 0.2
@export var lerpSpeed : float = 1.5
@onready var accel = 10
@export var speed : float = 1
@export var target : Node3D
var isSeated = false
var destination : Vector3
var manager
enum Drinks {
	ORANGE,
	RED,
	PURPLE,
	BLUE,
}
var desiredDrink: Drinks = Drinks.ORANGE
var MyClass = preload("res://Boba/scripts/drink.gd")
var wantedDrink

func _ready() -> void:
	desiredDrink = Drinks.values().pick_random()
	manager = get_tree().get_first_node_in_group("Manager")
	destination = manager.GetChair()
	manager.RemoveChair(0)
func _physics_process(delta: float) -> void:
	var pos : Vector2 = Vector2(global_position.x, global_position.z)
	var lookTarget : Vector2 = Vector2(destination.x, destination.z)
	var dir = (pos - lookTarget)
	rotation.y = lerp_angle(rotation.y, atan2(dir.x, dir.y), delta/lerpSpeed)
	if destination and global_position.distance_to(destination) > stoppingDistance:
		var direction = Vector3()
		agent.target_position = destination
		direction = agent.get_next_path_position() - global_position 
		direction = direction.normalized()
		velocity = velocity.lerp(direction * speed, accel * delta)
		move_and_slide()
	else:
		isSeated = true
