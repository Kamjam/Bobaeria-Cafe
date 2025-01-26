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
@export var studentAnimator: StudentAnimator

var isSeated = false
var hasOrder = false
var destination : Vector3
var manager
var instance
var chair : Node3D = null
@export var listToJudge : Array[int] = [0, 0, 0]
# 1 Bubbles, 2 Flavor, 3 Topping, 4 Sweetness, 5 Ice, 6 Cream, 7 Teabase
var judgeOne
var judgeTwo
var judgeThree
var textOne
var textTwo
var textThree

var drinkScore : int = 0
@onready var textScore : Label3D = $Score
@onready var timer : Timer = $Timer
@export var hasDrink : bool = false
func _init():
	randomize() 
	if listToJudge[0] == 0:
		listToJudge[0] = randi() % 6 + 1
		SetRandomDesire(1)
	while listToJudge[1] == 0:
		var num = randi() % 6 + 1
		if num != listToJudge[0]:
			listToJudge[1] = num
			SetRandomDesire(2)
			
	while listToJudge[2] == 0:
		var num = randi() % 6 + 1
		if num != listToJudge[0] and num != listToJudge[1]:
			listToJudge[2] = num
			SetRandomDesire(3)
			
	
	
	#print(listToJudge[0], listToJudge[1], listToJudge[2])
func SetRandomDesire(num):
	if num == 1:
		match listToJudge[0]:
			1:
				judgeOne = randi() % 9 + 1
				textOne = "Bubbles: " + str(judgeOne)
				print("Bubbles", judgeOne)
			2:
				judgeOne = Flavors.Flavor.values()[ randi()%Flavors.Flavor.size()]
				textOne = "Flavor: " + GetFlavor(judgeOne)
				print("Flavor", judgeOne)
			3:
				judgeOne = Toppings.Topping.values()[ randi()%Toppings.Topping.size()]
				textOne = "Topping: " + GetTopping(judgeOne)
				print("Topping", judgeOne)
			4:
				judgeOne = randi() % 9 + 1
				textOne = "Sweetness: " + str(judgeOne)
				print("Sweetness", judgeOne)
			5:
				judgeOne = randi() % 2 == 0
				textOne = "Cream: " + str(judgeOne)
				print("Cream", judgeOne)
			6:
				judgeOne = Teabase.Base.values()[ randi()%Teabase.Base.size()]
				textOne = "Teabase: " + GetTeaBase(judgeOne)
				print("Teabase", judgeOne)
	if num == 2:
		match listToJudge[1]:
			1:
				judgeTwo = randi() % 9 + 1
				textTwo = "Bubbles: " + str(judgeTwo)
				print("Bubbles", judgeTwo)
			2:
				judgeTwo = Flavors.Flavor.values()[ randi()%Flavors.Flavor.size()]
				textTwo = "Flavor: " + GetFlavor(judgeTwo)
				print("Flavor", judgeTwo)
			3:
				judgeTwo = Toppings.Topping.values()[ randi()%Toppings.Topping.size()]
				textTwo = "Topping: " + GetTopping(judgeTwo)
				print("Topping", judgeTwo)
			4:
				judgeTwo = randi() % 9 + 1
				textTwo = "Sweetness: " + str(judgeTwo)
				print("Sweetness", judgeTwo)
			5:
				judgeTwo = randi() % 2 == 0
				textTwo = "Cream: " + str(judgeTwo)
				print("Cream", judgeTwo)
			6:
				judgeTwo = Teabase.Base.values()[ randi()%Teabase.Base.size()]
				textTwo = "Teabase: " + GetTeaBase(judgeTwo)
				print("Teabase", judgeTwo)		
	if num == 3:
		match listToJudge[2]:
			1:
				judgeThree = randi() % 9 + 1
				textThree = "Bubbles: " + str(judgeThree)
				
				print("Bubbles", judgeThree)
			2:
				judgeThree = Flavors.Flavor.values()[ randi()%Flavors.Flavor.size()]
				textThree = "Flavor: " + GetFlavor(judgeThree)
				
				print("Flavor", judgeThree)
			3:
				judgeThree = Toppings.Topping.values()[ randi()%Toppings.Topping.size()]
				textThree = "Topping: " + GetTopping(judgeThree)
				
				print("Topping", judgeThree)
			4:
				judgeThree = randi() % 9 + 1
				textThree = "Sweetness: " + str(judgeThree)
				
				print("Sweetness", judgeThree)
			5:
				judgeThree = randi() % 2 == 0
				textThree = "Cream: " + str(judgeThree)
				
				print("Cream", judgeThree)		
			6:
				judgeThree = Teabase.Base.values()[ randi()%Teabase.Base.size()]
				textThree = "Teabase: " + GetTeaBase(judgeThree)
				
				print("Teabase", judgeThree)	
func JudgeDrink(otherDrink : bobaDrink) -> int:
	match listToJudge[0]:
			1:
				if judgeOne >= (otherDrink.bubbleLevel -1) and judgeOne <= (otherDrink.bubbleLevel +1):
					drinkScore+=20
			2:
				if judgeOne == otherDrink.flavor:
					drinkScore+=20
			3:
				if judgeOne == otherDrink.topping:
					drinkScore+=20
			4:
				if judgeOne >= (otherDrink.sweetness -1) and judgeOne <= (otherDrink.sweetness +1):
					drinkScore+=20
			5:
				if judgeOne == otherDrink.hasWhippedCream:
					drinkScore+=20
			6: 
				if judgeOne == otherDrink.teaBase:
					drinkScore+=20
	match listToJudge[1]:
			1:
				if judgeTwo >= (otherDrink.bubbleLevel -1) and judgeTwo <= (otherDrink.bubbleLevel +1):
					drinkScore+=20
			2:
				if judgeTwo == otherDrink.flavor:
					drinkScore+=20
			3:
				if judgeTwo == otherDrink.topping:
					drinkScore+=20
			4:
				if judgeTwo >= (otherDrink.sweetness -1) and judgeTwo <= (otherDrink.sweetness +1):
					drinkScore+=20
			5:
				if judgeTwo == otherDrink.hasWhippedCream:
					drinkScore+=20
			6: 
				if judgeTwo == otherDrink.teaBase:
					drinkScore+=20
	match listToJudge[2]:
			1:
				if judgeThree >= (otherDrink.bubbleLevel -1) and judgeThree <= (otherDrink.bubbleLevel +1):
					drinkScore+=20
			2:
				if judgeThree == otherDrink.flavor:
					drinkScore+=20
			3:
				if judgeThree == otherDrink.topping:
					drinkScore+=20
			4:
				if judgeThree >= (otherDrink.sweetness -1) and judgeThree <= (otherDrink.sweetness +1):
					drinkScore+=20
			5:
				if judgeThree == otherDrink.hasWhippedCream:
					drinkScore+=20
			6: 
				if judgeThree == otherDrink.teaBase:
					drinkScore+=20
	print("YOU SCORED" ,drinkScore)
	textScore.text = "" + str(drinkScore)
	if instance:
		instance.queue_free()
		instance = null
	hasDrink = true
	ShowScore()
	return drinkScore
func ShowScore():
	await get_tree().create_timer(10).timeout
	textScore.show()
	
func _ready() -> void:
	manager = get_tree().get_first_node_in_group("Manager")
	chair = manager.GetChair()
	destination = chair.position
	manager.RemoveChair(0)
	
	studentAnimator.play_left()

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
	elif !isSeated:
		Thinking()
		isSeated = true
	

func Thinking():
	studentAnimator.pause()
	
	await get_tree().create_timer(thinkingTime).timeout
	hasOrder = true
	instance = thoughtBubble.instantiate()
	instance.position = bubblePos.global_position
	instance.rotation = Vector3(0,0,0)
	instance.SetBubbleText(textOne, textTwo, textThree)
	get_parent().add_child(instance)
	await get_tree().create_timer(leaveTime).timeout
	Leave()

func Leave():
	
	studentAnimator.play_left()
	
	destination = manager.GetExit()
	if instance:
		instance.queue_free()
		instance = null
	await get_tree().create_timer(15).timeout
	manager.AddChair(chair)
	
	studentAnimator.play_left()
	
	queue_free()


func GetTeaBase(num) -> String:
	match num:
			0:
				return "Milk Tea"
			1:
				return "Taro"
			2:
				return "Green Tea"
			3:
				return "Oolong"
			4:
				return "Black Tea"
	
	return "NONE"
func GetFlavor(num) -> String:
	match num:
			0:
				return "Original"
			1:
				return "HoneyDew"
			2:
				return "Coffee"
			3:
				return "Bananna"
			4: 
				return "Coconut"
	return "NONE"			
func GetTopping(num) -> String:
	match num:
			0:
				return "Oreo"
			1:
				return "Jelly"
			2:
				return "Red Bean"
			3:
				return "Popping Bubbles"
	
	return "NONE"			
