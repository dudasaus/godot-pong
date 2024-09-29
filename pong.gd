extends Node2D

var paddle_margin = 32

func _ready() -> void:
	create_goals()
	
func create_goals():
	$AIPlayer.get_node("score").player_index = 0
	$AIPlayer.get_node("score").connect("score_signal", $Ui._on_pong_score_signal)
	$AIPlayer.get_node("score").connect("score_signal", reset_ball)

	$Player.get_node("score").player_index = 1
	$Player.get_node("score").connect("score_signal", $Ui._on_pong_score_signal)
	$Player.get_node("score").connect("score_signal", reset_ball)
	
func reset_ball(_index: Variant) -> void:
	$ball.reset()
