extends Area2D

@export var player_index = 0
@export var score_signal: Signal

func _on_body_entered(body: Node2D) -> void:
	if body.has_meta('is_ball'):
		score_signal.emit(player_index)
