extends Area3D

var isOpening = false 


@onready var thisNode = $DoorHinge

func _physics_process(delta: float) -> void:
	if isOpening and thisNode.rotation.y > -2.2 :
		thisNode.rotation.y -= 0.02
	if !isOpening and thisNode.rotation.y < 0 :
		thisNode.rotation.y += 0.02

	


func _on_body_entered(body: Node3D) -> void:
	isOpening = true
	print(body)
	


func _on_body_exited(body: Node3D) -> void:
	isOpening = false
