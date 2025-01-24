extends Node

@export var avaliableChairs : Array[Node3D]
@export var allChairs : Array[Node3D]
@export var exit : Node3D



func _ready() -> void:
	for h in allChairs:
		avaliableChairs.append(h)
func GetChair() -> Vector3:
	return avaliableChairs[0].global_position
func RemoveChair(a):
	avaliableChairs.remove_at(a)
	print("Removed")
