extends Node

#func _ready() -> void:
	#for child in self.get_children():
		#if (child is CheckBox):
			#child.to
#toggles button on and off based on connected checkbox.toggled signals
#added button name to connected checkbox.toggled signals
#the signal needs to be updated if the button's name is changed
func on_radio_button_toggeled(button_pressed, name):
	
	if button_pressed == false:
		return
	
	for child in self.get_children():
		if (child is CheckBox and child.name != name):
			child.button_pressed = false
