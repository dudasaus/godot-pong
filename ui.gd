@tool
extends Control

@export var num_players = 2
var player_scores = []

func _ready() -> void:
	position.x = get_viewport_rect().get_center().x
	position.y = 16
	for i in range(num_players):
		player_scores.append(0)
	update_score_label()


func update_score_label():
	var text = " - ".join(player_scores)
	$ScoreLabel.text = text


func _on_pong_score_signal(index: Variant) -> void:
	player_scores[index] = player_scores[index] + 1
	update_score_label()
