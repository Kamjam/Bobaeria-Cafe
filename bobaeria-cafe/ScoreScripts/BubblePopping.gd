extends Camera3D

func _process(delta: float) -> void:
	ToCursor()

func ToCursor():
	var mouse_pos = get_viewport().get_mouse_position()
	var rayLength = 1000
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * rayLength
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.collide_with_areas = true
	ray_query.from = from
	ray_query.to = to
	var raycast_result = space.intersect_ray(ray_query)
	if !raycast_result.is_empty() and Input.is_action_just_pressed("fire"):
		print(raycast_result.collider)
		if raycast_result.collider is DrinkBubble:
			var bubble: DrinkBubble = raycast_result.collider
			print("found bubble: ", bubble)
			print(bubble.name)
			bubble.pop_bubble()
