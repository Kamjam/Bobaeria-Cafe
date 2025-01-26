extends CanvasLayer

@export var animator:AnimationPlayer

var is_open:bool = false
var first_steps:bool = false

func _ready():
	self.visible = false
	pass

func _process(delta):
	check_first()
	if Input.is_action_just_pressed("toggle_tutorial_overlay"):
		if(is_open):
			close_tutorial()
		else:
			open_tutorial()

func check_first():
		if not first_steps and \
		(Input.is_action_pressed("up") or \
		Input.is_action_pressed("left") or \
		Input.is_action_pressed("down") or \
		Input.is_action_pressed("right")):
			open_tutorial()
			first_steps = true

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
