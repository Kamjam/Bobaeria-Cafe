#https://youtu.be/E4ybJVTXq1A
extends Control

@export var changescenetimer:Timer
@export var audioplayer:AudioStreamPlayer2D

func _ready():
	changescenetimer.start()

func _on_timer_timeout() -> void:
	print('change scene')
	get_tree().change_scene_to_file("res://Scenes/JoeMama.tscn")
