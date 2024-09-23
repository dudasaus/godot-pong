extends Node2D

var paddle_scene = preload("res://paddle.tscn")

var paddle_margin = 32

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_paddles()
	
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

	$score2.connect("score_signal", $Ui._on_pong_score_signal)
	$score.connect("score_signal", $Ui._on_pong_score_signal) 
	$score2.connect("score_signal", reset_ball)
	$score.connect("score_signal", reset_ball)
	
func reset_ball(index: Variant) -> void:
	$ball.reset()
