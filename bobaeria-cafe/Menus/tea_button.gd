extends Button

@export var menu:Node
@export var viewport:Viewport
@export var sprite:Sprite2D
@export var display_tea:Node
@export var menu_btn:Button
@export var timer:Timer

func _ready() -> void:
	display_tea.visible = false
	var texture = viewport.get_texture()
	sprite.texture = texture
	
func _on_pressed() -> void:
	menu.visible = false
	display_tea.visible = true
	menu_btn.disabled = true
	timer.start()

func _on_display_timeout() -> void:
	menu.visible = true
	display_tea.visible = false
	menu_btn.disabled = false
