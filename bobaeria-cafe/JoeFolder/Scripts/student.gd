class_name Student
extends CharacterBody3D

@export var agent : NavigationAgent3D
@export var stoppingDistance : float = 0.3
@export var lerpSpeed : float = 1.5
@onready var accel = 10
@export var speed : float = 1
@export var target : Node3D
@export var thinkingTime : float = 3
@export var leaveTime : float = 4

@export var thoughtBubble : PackedScene
@export var bubblePos : Node3D

var isSeated = false
var destination : Vector3
var manager
var boba : Boba.Boba
var instance
var chair : Node3D = null
func _ready() -> void:
	var a :int = Boba.Boba.values()[ randi()%Boba.Boba.size() ]
	boba = a
	print(boba)
	manager = get_tree().get_first_node_in_group("Manager")
	chair = manager.GetChair()
	destination = chair.position
	manager.RemoveChair(0)
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed(""):
		Leave()
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
		print(global_position.distance_to(destination))
		
		move_and_slide()
	elif !isSeated:
		print("Once?")
		Thinking()
		isSeated = true
	

func Thinking():
	await get_tree().create_timer(thinkingTime).timeout
	instance = thoughtBubble.instantiate()
	instance.position = bubblePos.global_position
	instance.rotation = Vector3(0,0,0)
	get_parent().add_child(instance)
	await get_tree().create_timer(leaveTime).timeout
	Leave()
func Leave():
	destination = manager.GetExit()
	if instance:
		instance.queue_free()
	await get_tree().create_timer(6).timeout
	manager.AddChair(chair)
	queue_free()
