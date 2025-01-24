extends Node

@export var student : PackedScene
@export var spawnPosition : Node3D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		SpawnStudent()
func SpawnStudent():
	var instance = student.instantiate()
	instance.position = spawnPosition.global_position
	instance.rotation = Vector3(0,0,0)
	get_parent().add_child(instance)
