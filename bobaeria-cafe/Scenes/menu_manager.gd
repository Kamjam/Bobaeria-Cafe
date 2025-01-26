extends Node

@export_category("THE POPUP MENUS")
@export var tutorial_overlay:Node
@export var esc_menu:Node
@export var recipe_menu:Node

var is_one_open:bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if tutorial_overlay.visible == true:
		esc_menu.process_mode = Node.PROCESS_MODE_DISABLED
		recipe_menu.process_mode = Node.PROCESS_MODE_DISABLED
	elif esc_menu.visible == true:
		tutorial_overlay.process_mode = Node.PROCESS_MODE_DISABLED
		recipe_menu.process_mode = Node.PROCESS_MODE_DISABLED
	elif recipe_menu.visible == true:
		tutorial_overlay.process_mode = Node.PROCESS_MODE_DISABLED
		esc_menu.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		tutorial_overlay.process_mode = Node.PROCESS_MODE_ALWAYS
		esc_menu.process_mode = Node.PROCESS_MODE_ALWAYS
		recipe_menu.process_mode = Node.PROCESS_MODE_ALWAYS
