extends Control

var shader_material:ShaderMaterial
var is_mouse_in = false
var texture

func _ready():
	shader_material = self.material
	texture = self.texture

func _process(_delta):
	if is_mouse_in == true:
		var mouse_pos = get_local_mouse_position()
		var button_size = self.size
		var normalized_mouse_pos = mouse_pos / button_size
		shader_material.set_shader_parameter("mouse_position", normalized_mouse_pos)

func _on_mouse_entered():
	is_mouse_in = true

func _on_mouse_exited():
	is_mouse_in = false
	shader_material.set_shader_parameter("mouse_position", Vector2(0.5, 0.5))
