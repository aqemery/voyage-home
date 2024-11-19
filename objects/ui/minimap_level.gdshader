shader_type canvas_item;

void vertex() {
  VERTEX += vec2(cos(TIME)*1.0, -sin(TIME)*1.0);
}

void fragment() {
    //COLOR = vec4(UV, 1.0, UV.);
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
