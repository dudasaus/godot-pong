shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float fps = 24.0;
uniform bool glitching = true;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}

void fragment() {
	vec4 final_color = texture(screen_texture, UV);
	if (glitching) {
		float frame = floor(TIME * fps);
		float offset_strength = random(vec2(frame)) * 2.0;
		vec2 offset = SCREEN_PIXEL_SIZE * vec2(offset_strength);
		float r_sample = texture(screen_texture, SCREEN_UV + offset).r;
		float b_sample = texture(screen_texture, SCREEN_UV - offset).b;
		final_color.r = max(r_sample, final_color.r);
		final_color.b = max(b_sample, final_color.b);
		final_color.g = max(b_sample, final_color.g);
	}
	COLOR = final_color;
}
