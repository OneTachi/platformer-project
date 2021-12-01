shader_type canvas_item;

uniform float time_factor = 1;
uniform vec2 amplitude = vec2(20.0, 5.0);

void vertex() 
{
	VERTEX.x += cos(TIME * time_factor) * amplitude.x;
	VERTEX.y += sin(TIME) * amplitude.y;
}

void fragment() 
{
	//COLOR = vec4(UV, 0.0, 1.0);
}