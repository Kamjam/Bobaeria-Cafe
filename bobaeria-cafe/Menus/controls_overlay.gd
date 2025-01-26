extends CanvasLayer

@export var animator:AnimationPlayer

var is_open:bool = false
var first_steps:bool = false

func _ready():
	self.visible = false
	pass

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		if(is_open):
			close_tutorial()
		else:
			open_tutorial()

func close_tutorial():
		animator.play("panel_fade_out")
		await animator.animation_finished
		get_tree().paused = false
		self.visible = false
		is_open = false

func open_tutorial():
		get_tree().paused = true
		self.visible = true
		animator.play("panel_fade_in")
		is_open = true

func _on_resume_button_down() -> void:
	close_tutorial()

func _on_load_button_down() -> void:
	pass # Replace with function body.

func _on_exit_button_down() -> void:
	get_tree().quit()
