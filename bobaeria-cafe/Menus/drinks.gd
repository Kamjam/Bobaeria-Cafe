extends VBoxContainer

@export var Names:Array[String]

func _ready() -> void:
	for i in get_children():
		i.text = Names[i.get_index()]
