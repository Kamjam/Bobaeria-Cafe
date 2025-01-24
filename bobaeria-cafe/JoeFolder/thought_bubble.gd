extends MeshInstance3D
var cam : Node3D

func _ready() -> void:
	cam = get_tree().get_first_node_in_group("Cam")
func _physics_process(delta: float) -> void:
	look_at(cam.global_position)
