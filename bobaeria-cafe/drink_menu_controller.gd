class_name DrinkMenuController
extends Node3D

@export var _drink_constructor_node: Control

func enable_constructor_menu():
	_drink_constructor_node.visible = !_drink_constructor_node.visible

func SetFalse():
	_drink_constructor_node.visible = false
