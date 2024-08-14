shader_type canvas_item;



void fragment() {
	float alpha = 0.4 + 0.5 * sin(TIME * 16.0);
    COLOR.a = alpha + 0.1;
}
