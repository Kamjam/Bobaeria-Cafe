extends Node

@export var avaliableChairs : Array[Node3D]
@export var allChairs : Array[Node3D]
@export var exit : Node3D



func _ready() -> void:
	for h in allChairs:
		avaliableChairs.append(h)
func GetChair() -> Node3D:
	return avaliableChairs[0]
func RemoveChair(a):
	avaliableChairs.remove_at(a)
	print("Removed")
func AddChair(i):
	avaliableChairs.append(i)
func GetExit() -> Vector3:
	return exit.global_position
	
