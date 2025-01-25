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
var instance
var chair : Node3D = null
@export var listToJudge : Array[int] = [0, 0, 0]
# 1 Bubbles, 2 Flavor, 3 Topping, 4 Sweetness, 5 Ice, 6 Cream
var judgeOne
var judgeTwo
var judgeThree

func _init():
	randomize() 
	if listToJudge[0] == 0:
		listToJudge[0] = randi() % 5 + 1
		SetRandomDesire(1)
	while listToJudge[1] == 0:
		var num = randi() % 5 + 1
		if num != listToJudge[0]:
			listToJudge[1] = num
	while listToJudge[2] == 0:
		var num = randi() % 5 + 1
		if num != listToJudge[0] and num != listToJudge[1]:
			listToJudge[2] = num
	#print(listToJudge[0], listToJudge[1], listToJudge[2])
func SetRandomDesire(num):
	if num == 1:
		match listToJudge[0]:
			1:
				judgeOne = randi() % 9 + 1
				print("Bubbles", judgeOne)
			2:
				judgeOne = Flavors.Flavor.values()[ randi()%Flavors.Flavor.size()]
				print("Flavor", judgeOne)
			3:
				judgeOne = Toppings.Topping.values()[ randi()%Toppings.Topping.size()]
				print("Topping", judgeOne)
			4:
				judgeOne = randi() % 9 + 1
				print("Sweetness", judgeOne)
			5:
				judgeOne = randi() % 2 == 0
				print("Cream", judgeOne)
				
			
func JudgeDrink():
	#match listToJudge[0]:
			#1:
				#pass
			#2:
				#judgeOne = (Other drinks value)
				#Add score
			#3:
				#pass
			#4:
				#pass
			#5:
				#pass
	pass
func _ready() -> void:
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
		move_and_slide()
	elif !isSeated:
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
	await get_tree().create_timer(10).timeout
	manager.AddChair(chair)
	queue_free()
