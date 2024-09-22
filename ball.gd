extends CharacterBody2D


const SPEED = 300.0

func _init() -> void:
	var direction = Vector2.LEFT;
	velocity = direction * SPEED;

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
