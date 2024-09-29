extends CharacterBody2D

var initial_speed = 500.0

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
			var paddle_pos = collider.global_position as Vector2
			velocity = paddle_pos.direction_to(global_position) * speed
			GlobalEffects.glitch.glitch_for(1)
		else:
			velocity = velocity.bounce(collision_info.get_normal())
		$beep.play()

func reset():
	position = get_viewport_rect().get_center()
	var initial_direction = Vector2.LEFT if randf() < 0.5 else Vector2.RIGHT
	velocity = initial_direction * initial_speed
