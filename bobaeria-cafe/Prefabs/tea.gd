extends Area3D

var selected = false
var player



#func _ready() -> void:
	#player = get_tree().get_first_node_in_group("player")
	##player.interact_object.connect(_set_selected)
