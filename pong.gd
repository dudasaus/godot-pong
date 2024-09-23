extends Node2D

var paddle_scene = preload("res://paddle.tscn")
var goal_scene = preload("res://score_boundary.tscn")

var paddle_margin = 32

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_paddles()
	create_goals()
	
func create_paddles():
	var start_y = get_viewport_rect().get_center().y
	var p1 = paddle_scene.instantiate()
	p1.name = "paddle_1"
	p1.position = Vector2(paddle_margin, start_y)
	add_child(p1)

	var p2 = paddle_scene.instantiate()
	p2.name = "paddle_2"
	p2.position = Vector2(get_viewport_rect().size.x - paddle_margin, start_y)
	add_child(p2)

	#$score2.connect("score_signal", $Ui._on_pong_score_signal)
	#$score.connect("score_signal", $Ui._on_pong_score_signal) 
	#$score2.connect("score_signal", reset_ball)
	#$score.connect("score_signal", reset_ball)
	
func create_goals():
	var g1 = goal_scene.instantiate()
	g1.player_index = 1
	add_child(g1)
	
	var right_side = get_viewport_rect().size.x
	var g2 = goal_scene.instantiate()
	g2.rotate(PI)
	g2.position = Vector2(right_side, g2.position.y)
	g2.player_index = 0
	add_child(g2)
	
	for goal in [g1, g2]:
		goal.connect("score_signal", $Ui._on_pong_score_signal)
		goal.connect("score_signal", reset_ball) 
	
	
func reset_ball(index: Variant) -> void:
	$ball.reset()
