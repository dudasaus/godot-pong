extends CharacterBody2D


var speed = 300.0
var speed_increase = 20.0

func _init() -> void:
	var direction = Vector2.LEFT;
	velocity = direction * speed;

func _physics_process(delta: float) -> void:
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
