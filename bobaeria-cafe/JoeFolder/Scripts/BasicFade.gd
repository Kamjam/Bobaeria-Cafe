extends Node

@onready var anim = $AnimationPlayer

func _ready() -> void:
	$ColorRect.show()
	anim.play("Fade")
	await get_tree().create_timer(3).timeout
	queue_free()
