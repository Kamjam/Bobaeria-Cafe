class_name Player
extends CharacterBody3D

const SPEED = 5.0

var pickedObject: bool = false
var interactables: Array[Area3D] 
var byTrashCan: bool = false
var menuController: DrinkMenuController
var canMove : bool = true
var students: Array[CharacterBody3D]

var input_dir: Vector2

var horrizontalLastDirrection: float

@export var currentDrink : bobaDrink
@export var animator: PlayerAnimator
signal AddScore(num : int)
signal DrinkPickedUp(drink: Node3D)
@onready var dayEnd = $"../DayEndManager"
@onready var audioSource = $AudioStreamPlayer3D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if canMove:
		# Get the input direction and handle the movement/deceleration.
		input_dir = Input.get_vector("left", "right", "up", "down")
		
		if input_dir.x != 0:
			
			horrizontalLastDirrection = input_dir.x
		
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		
		move_and_slide()
		_player_animation()
	else:
		animator.play_idle()
	
func _input(event):	
	if event.is_action_pressed("interact") and interactables.size() > 0 and !pickedObject:
		currentDrink = interactables[0]._drink_resource
		interactables[0].reparent(get_tree().current_scene)
		pick_up_object(interactables[0])
		audioSource.play()
		pickedObject = true
		DrinkPickedUp.emit(interactables[0])
	
	elif event.is_action_pressed("interact") and pickedObject and students.size() > 0:
		if students[0].hasOrder and students[0].hasDrink == false:
			dayEnd.SetGiven()
			var num = students[0].JudgeDrink(currentDrink)
			AddScore.emit(num)
			students.remove_at(0)
			interactables[0].queue_free()
			interactables.remove_at(0)
			audioSource.play()
			pickedObject = false
	elif event.is_action_pressed("interact") and pickedObject and byTrashCan:
		interactables[0].queue_free()
		interactables.remove_at(0)
		pickedObject = false
		audioSource.play()
		
	elif event.is_action_pressed("interact") and menuController != null:
		menuController.enable_constructor_menu()
		canMove = !canMove

func pick_up_object(object):
	object.reparent(self)
	object.global_position = %CarryTeaMarker.global_position

func _on_pickup_area_area_entered(area: Area3D) -> void:
	if area is Tea:
		interactables.append(area)
	

func _on_pickup_area_area_exited(area: Area3D) -> void:
	if area is Tea:
		interactables.erase(area)
	
	

func _on_pickup_area_body_entered(body: Node3D) -> void:
	if body is Student:
		students.append(body)
	
	if body is ThisIsTrashCan:
		byTrashCan = true
	
	if body is DrinkMenuController:
		menuController = body

func _on_pickup_area_body_exited(body: Node3D) -> void:
	if body is ThisIsTrashCan:
		byTrashCan = false
	if body is Student:
		students.erase(body)
	if body is DrinkMenuController:
		menuController = null
	

func _player_animation():
	
	if input_dir == Vector2.ZERO:
		
		if horrizontalLastDirrection < 0:
			
			animator.set_player_facing_left(true)
		
		elif horrizontalLastDirrection > 0:
			
			animator.set_player_facing_left(false)
			
		animator.play_idle()
	
	else:
		if horrizontalLastDirrection < 0:
			
			animator.set_player_facing_left(true)
		
		elif horrizontalLastDirrection > 0:
			
			animator.set_player_facing_left(false)
			
		animator.play_walk()
