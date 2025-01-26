extends Node

@export var label: Label

func print_slider_level(value: float):
	label.text = str(value)
