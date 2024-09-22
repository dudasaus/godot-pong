extends StaticBody2D


const SPEED = 300.0
var velocity = Vector2.ZERO
var height = 120.0
var min_pos_y = 0.0 + height / 2.0
var max_pos_y

func _ready() -> void:
	max_pos_y = get_viewport_rect().size.y - height / 2.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)

	position += velocity * delta
	position.y = clamp(position.y, min_pos_y, max_pos_y)
