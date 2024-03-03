shader_type canvas_item;

uniform float time : hint_range(0.0, 10.0) = 0.0; // Time variable
uniform float speed : hint_range(0.0, 10.0) = 1.0; // Speed of shimmering effect
uniform float scale : hint_range(0.0, 10.0) = 1.0; // Scale of noise
uniform vec2 screen_size; // Screen size uniform

// Perlin noise texture
uniform sampler2D noise_texture;

void fragment() {
    // Calculate offset using time
    vec2 offset = vec2(cos(time * speed), sin(time * speed));

    // Calculate UV coordinates
    vec2 uv = FRAGCOORD.xy / screen_size + offset * 0.1;

    // Sample from noise texture
    vec4 noise_value = texture(noise_texture, uv * scale);

    // Sample the texture
    vec4 texColor = texture(TEXTURE, uv + noise_value.xy * 0.1);

    // Output color
    COLOR = texColor;
}
