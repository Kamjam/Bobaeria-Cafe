extends MeshInstance3D
var cam : Node3D
@export var one : Label3D
@export var two : Label3D
@export var three : Label3D


func _ready() -> void:
	cam = get_tree().get_first_node_in_group("Cam")
func _physics_process(delta: float) -> void:
	look_at(cam.global_position)
func SetBubbleText(stringOne, stringTwo, stringThree):
	one.text = stringOne
	two.text = stringTwo
	three.text = stringThree
	
