shader_type canvas_item;

uniform vec2 point;
uniform float max_distance = 0.05;

void fragment() {
	float d = distance(point, UV);
	// if distance is less than distance
	if (d < max_distance) {
		// set alpha to 0
		COLOR.a = 0.0;
	}
}
