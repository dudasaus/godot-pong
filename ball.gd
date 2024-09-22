extends CharacterBody2D

var initial_speed = 300.0
var initial_direction = Vector2.LEFT

var speed_increase = 20.0

func _ready() -> void:
	reset()

func _physics_process(delta: float) -> void:
	var speed = velocity.length()
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var collider = collision_info.get_collider()
		if collider.has_meta("is_paddle"):
			print(collider.name)
			speed += speed_increase
			var paddle_pos = collider.position as Vector2
			velocity = paddle_pos.direction_to(position) * speed
		else:
			velocity = velocity.bounce(collision_info.get_normal())
		$beep.play()

func reset():
	position = get_viewport_rect().get_center()
	velocity = initial_direction * initial_speed


func _on_pong_score_signal(index: Variant) -> void:
	reset()
