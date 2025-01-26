class_name PlayerAnimator
extends Node

@export var _animated_sprite: AnimatedSprite3D

var _player_facing_left: bool

func play_walk():
	
	if _player_facing_left:
		
		_animated_sprite.play("Player_Walk_Left")
	
	else:
		
		_animated_sprite.play("Player_Walk_Right")

func play_idle():
	
	if _player_facing_left:
		
		_animated_sprite.play("Player_Idle_Left")
	
	else:
		
		_animated_sprite.play("Player_Idle_Right")

func set_player_facing_left(facing_left: bool):
	
	_player_facing_left = facing_left
