extends Button

@export var animator:AnimationPlayer
@export var overlay:Node

var is_open:bool = false

func _ready():
	overlay.visible = false
	pass

func close_tutorial():
		animator.play("panel_fade_out")
		await animator.animation_finished
		get_tree().paused = false
		overlay.visible = false
		is_open = false

func open_tutorial():
		get_tree().paused = true
		overlay.visible = true
		animator.play("panel_fade_in")
		is_open = true


func _on_button_down() -> void:
	if(is_open):
		close_tutorial()
	else:
		open_tutorial()
