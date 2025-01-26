#https://youtu.be/zFv6O7PP2d0
extends Control

@onready var items = $VBoxContainer/ScrollContainer/Drinks.get_children()

var matches = []

func _on_search_text_changed(new_text: String) -> void:
	new_text = new_text.to_lower()
	if new_text == "":
		for i in items:
			i.show()
		return
	
	matches.clear()
	
	for i in items:
		if new_text in i.text.to_lower():
			matches.append(i)
	
	for i in items:
		if i in matches:
			i.show()
		else:
			i.hide()
		
