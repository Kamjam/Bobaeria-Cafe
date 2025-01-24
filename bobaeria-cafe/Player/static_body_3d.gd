extends CharacterBody3D

const SPEED = 5.0

var pickedObject

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
	
	if event.is_action_pressed("interaction") and pickedObject:
		pickedObject.reparent(get_tree().current_scene)
		pickedObject = null

func pick_up_object(object):
	object.reparent(self)
	object.global_position = %CarryTeaMarker.global_position
	
	await get_tree().create_timer(0.1).timeout
	pickedObject = object
