extends Node2D

var paddle_margin = 8
var stage = 0

func _ready() -> void:
	position_players()
	create_goals()

func position_players():
	var start_y = get_viewport_rect().get_center().y
	
	var p1 = $Player
	p1.position = Vector2(paddle_margin, start_y)

	var p2 = $AIPlayer
	p2.position = Vector2(get_viewport_rect().size.x - paddle_margin, start_y)

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
	var should_reset = true
	if(ai_scored_on):
		stage += 1
		if (stage == 1):
			%ConversationService.queue_messages(['Nice shot.', 2.5, '$clear'])
		elif stage == 2:
			should_reset = false
			var msgs = [
				"This doesn't seem very fair.",
				1.5,
				"Let me fix that.",
				1.5,
				"/set_speed(ai, player_speed)",
				4.0,
				'$clear'
			]
			%ConversationService.queue_messages(msgs)
			var ai_text = preload("res://ai_text.tscn")
			var text = ai_text.instantiate()
			text.position = %TextLocation.position
			add_child(text)
			$AIPlayer.get_node("MovementController").speed = 350.0
			get_tree().create_timer(6.3).timeout.connect(reset_ball)
			$ball.reset()
			$ball.velocity = Vector2(0, 0);
		
	if should_reset:
		reset_ball()

func reset_ball() -> void:
	$ball.reset()
