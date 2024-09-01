shader_type canvas_item;

// pass in point
uniform vec2 point;

void fragment() {
	// distance arround point if transparent
	float max_distance = 0.05;
	// distance from point
	float d = distance(point, UV);
	// if distance is less than distance
	if (d < max_distance) {
		// set alpha to 0
		COLOR.a = 0.0;
	}

}

