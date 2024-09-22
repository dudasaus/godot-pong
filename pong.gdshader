shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform float time_to_red = 30.0;

void fragment() {
	vec4 current_color = texture(screen_texture, UV);
	float redness = min(1.0, TIME / time_to_red);
	vec4 red_color = current_color * vec4(1.0, 0.0, 0.0, 1.0);
	COLOR = mix(current_color, red_color, redness);
}
