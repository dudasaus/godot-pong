extends Node2D

const SPEED = 100.0
var velocity = Vector2.ZERO
var height = 120.0
var min_pos_y = 0.0 + height / 2.0
var max_pos_y

func _ready() -> void:
	max_pos_y = get_viewport_rect().size.y - height / 2.0
	
func move_by(delta: float) -> Vector2:
	var diff = get_tree().get_nodes_in_group("ball").front().global_position.y - %paddle.global_position.y
	if abs(diff) < 10:
		return Vector2(0, 0)
	var direction = Vector2.DOWN if diff > 0.0 else Vector2.UP
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity = move_toward(velocity.x, 0, SPEED)
		
	var would_move_discance = (velocity * delta).length()

	return velocity * delta
