extends Node


@export var player_score: int
@export var text_satisfaction : Label
@export var text_failed : Label
@export var text_perfect : Label

var perfectDrinks : int = 0
var failedDrinks: int = 0


signal score_updated(updated_score: int)

func add_score(added_score: int):
	player_score += added_score
	if added_score == 60:
		perfectDrinks += 1
		text_perfect.text = str(perfectDrinks)
	if added_score == 0:
		failedDrinks += 1
		text_failed.text = str(failedDrinks)
	text_satisfaction.text = str(player_score)
	score_updated.emit(player_score)

func set_player_score(set_score: int):
	player_score = set_score


func _on_player_add_score(num: int) -> void:
	add_score(num)
	
