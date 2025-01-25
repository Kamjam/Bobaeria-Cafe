extends CharacterBody3D

const SPEED = 5.0

var pickedObject: bool = false
var interactables: Array[Area3D] 
var byTrashCan: bool = false
var menuController: DrinkMenuController

var students: Array[CharacterBody3D]
@export var currentDrink : bobaDrink

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()

func _input(event):
	if event.is_action_pressed("quit"):get_tree().quit()
	
	if event.is_action_pressed("interact") and interactables.size() > 0 and !pickedObject:
		
		interactables[0].reparent(get_tree().current_scene)
		pick_up_object(interactables[0])
		
		pickedObject = true
		print("grabbed")
	
	elif event.is_action_pressed("interact") and pickedObject and students.size() > 0:
		if students[0].hasDrink == false:
			students[0].JudgeDrink(currentDrink)
			students.remove_at(0)
			interactables[0].queue_free()
			interactables.remove_at(0)
			pickedObject = false
	elif event.is_action_pressed("interact") and pickedObject and byTrashCan:
		interactables[0].queue_free()
		interactables.remove_at(0)
		pickedObject = false
		print("trashed")
	elif event.is_action_pressed("interact") and menuController != null:
		menuController.enable_constructor_menu()
		print("menu opened")

func pick_up_object(object):
	object.reparent(self)
	object.global_position = %CarryTeaMarker.global_position

func _on_pickup_area_area_entered(area: Area3D) -> void:
	interactables.append(area)
	print("in area")
	

func _on_pickup_area_area_exited(area: Area3D) -> void:
	interactables.erase(area)
	print("out area")
	
	

func _on_pickup_area_body_entered(body: Node3D) -> void:
	if body is Student:
		students.append(body)
	
	if body is ThisIsTrashCan:
		byTrashCan = true
		print("trash can")
	
	if body is DrinkMenuController:
		menuController = body
		print("menuController")

func _on_pickup_area_body_exited(body: Node3D) -> void:
	if body is ThisIsTrashCan:
		byTrashCan = false
		print("not trash can")
	if body is Student:
		students.erase(body)
	if body is DrinkMenuController:
		menuController = null
