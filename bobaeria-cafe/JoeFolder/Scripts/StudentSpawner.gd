extends Node

@export var student : PackedScene
@export var spawnPosition : Node3D
@export var customerRate : float = 4
func _ready() -> void:
	LoopSpawn()
	
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_left"):
		SpawnStudent()
func LoopSpawn():
	await get_tree().create_timer(1).timeout
	
	SpawnStudent()
	
	await get_tree().create_timer(customerRate).timeout
	LoopSpawn()
	
func SpawnStudent():
	if get_tree().get_nodes_in_group("Student").size() < 8:
		var instance = student.instantiate()
		instance.position = spawnPosition.global_position
		instance.rotation = Vector3(0,0,0)
		get_parent().add_child(instance)
		
