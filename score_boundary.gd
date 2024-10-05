extends Area2D

@export var player_index = 0
signal score_signal(player_index)

func _ready():
	# Always move the score boundary to the nearest edge.
	var pos_multiplier = 1 \
		if global_position.x > get_viewport_rect().get_center().x \
		else 0
	global_position.x = get_viewport_rect().size.x * pos_multiplier
	

func _on_body_entered(body: Node2D) -> void:
	if body.has_meta('is_ball'):
		score_signal.emit(player_index)
