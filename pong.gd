extends Node2D

var paddle_margin = 32
var stage = 0

func _ready() -> void:
	create_goals()
	
func create_goals():
	var ai_score = $AIPlayer.get_node("score")
	ai_score.player_index = 0
	ai_score.connect("score_signal", $Ui._on_pong_score_signal)
	ai_score.connect("score_signal", scored_on)

	var player_score = $Player.get_node("score")
	player_score.player_index = 1
	player_score.connect("score_signal", $Ui._on_pong_score_signal)
	player_score.connect("score_signal", scored_on)
	
func scored_on(index: Variant) -> void:
	var ai_scored_on = index == 0
	if(ai_scored_on):
		stage += 1

	if(stage == 2 && ai_scored_on):
		var ai_text = preload("res://ai_text.tscn")
		var text = ai_text.instantiate()
		text.position = %TextLocation.position
		add_child(text)
		$AIPlayer.get_node("MovementController").speed = 350.0
		var timer = Timer.new()
		timer.wait_time = 6.3
		timer.timeout.connect(reset_ball)
		timer.one_shot = true
		add_child(timer)
		timer.start()
		$ball.reset()
		$ball.velocity = Vector2(0, 0);
		
	else:
		reset_ball()

func reset_ball() -> void:
	$ball.reset()
