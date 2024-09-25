extends CanvasLayer

func _ready() -> void:
	GlobalEffects.glitch = self

func glitch(on: bool):
	$ColorRect.material.set_shader_parameter('glitching', on)

func glitch_for(time_s: float):
	glitch(true)
	await get_tree().create_timer(time_s).timeout
	glitch(false)
