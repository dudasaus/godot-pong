extends Area2D

@export var player_index = 0
signal score_signal(player_index)

func _on_body_entered(body: Node2D) -> void:
	if body.has_meta('is_ball'):
		score_signal.emit(player_index)
		#emit_signal("score_signal", player_index)
