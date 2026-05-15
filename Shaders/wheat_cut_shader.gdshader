shader_type canvas_item;

varying vec2 vertex_local;

uniform float slope = 0;
uniform float offset = 0;

float random(float seed)
{
    return fract(sin(dot(seed, 12.9898)) * 43758.5453);
}

void vertex()
{
	vertex_local = VERTEX;
	// Called for every vertex the material is visible on.
}

void fragment()
{
	vec2 texture_size = 1.0/TEXTURE_PIXEL_SIZE;
	if (UV.y+clamp(sin(UV.x*1000.0),-.01,0) < (-slope*(UV.x-.5)+(-offset*TEXTURE_PIXEL_SIZE.x+1.0)))
	{
		COLOR.a = 0.0;
	}
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
