extends Node

@export var player_score: int

signal score_updated(updated_score: int)

func add_score(added_score: int):
	player_score += player_score
	score_updated.emit(player_score)

func set_player_score(set_score: int):
	player_score = set_score
