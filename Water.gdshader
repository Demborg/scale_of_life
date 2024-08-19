shader_type canvas_item;

uniform float scale = 1; 

uniform sampler2D NOISE_PATTERN;

uniform vec2 noise_vel = vec2(0.1, 0.3);

vec2 random(vec2 uv) {
	return vec2(fract(sin(dot(uv.xy,
		vec2(12.9898,78.233))) * 43758.5453123));
}

float worley(vec2 uv, float columns, float rows) {
	
	vec2 index_uv = floor(vec2(uv.x * columns, uv.y * rows));
	vec2 fract_uv = fract(vec2(uv.x * columns, uv.y * rows));
	
	float minimum_dist = 1.0;  
	
	for (int y= -1; y <= 1; y++) {
		for (int x= -1; x <= 1; x++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 point = random(index_uv + neighbor);
			
			vec2 diff = neighbor + point - fract_uv;
			float dist = length(diff);
			minimum_dist = min(minimum_dist, dist);
		}
	}
	
	return minimum_dist;
}

void fragment() {
	vec2 uv_scaled = scale * UV;
	vec2 offset = texture(NOISE_PATTERN, uv_scaled + TIME * noise_vel).xy * 0.2;
	float worley = worley(uv_scaled - TIME * noise_vel + offset, 1.0, 2.0);
	COLOR = vec4(1, 1, 1, worley);
}

