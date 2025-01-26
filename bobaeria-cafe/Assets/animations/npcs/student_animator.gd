class_name StudentAnimator
extends Node

#1 for blue animation 2 for pink animation
var _animation_type: int

@export var _sprite: AnimatedSprite3D

func _ready() -> void:
	
	_animation_type = randi_range(1,2)

func play_right():
	
	if _animation_type == 1:
		_sprite.play("M_Walk_Right")
	
	if _animation_type == 2:
		_sprite.play("W_Walk_Right")

func play_left():
	
	if _animation_type == 1:
		_sprite.play("M_Walk_Left")
	
	if _animation_type == 2:
		_sprite.play("W_Walk_Left")

func pause():
	_sprite.pause()
