shader_type canvas_item;

varying vec2 vertex_local;

uniform float slope = 0;
uniform float offset = 32;
uniform vec3 colorThing : source_color = vec3(1.0,1.0,1.0);
uniform float strength : hint_range(0.0,5.0) = 1.0;
uniform bool isGray;

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
	
	COLOR.rgb *= colorThing;
	if (isGray)
	{
		vec4 tex_color = texture(TEXTURE, UV);
	
		float gray = tex_color.r * 0.299 + tex_color.g * 0.587 + tex_color.b * 0.114;
 
		COLOR = vec4(vec3(gray), tex_color.a);
	}
	COLOR.rgb *= strength;
	
	vec2 texture_size = 1.0/TEXTURE_PIXEL_SIZE;
	if (UV.y+clamp(sin(UV.x*100.0),-.01,0) < (-slope*(UV.x-.5)+(-offset*TEXTURE_PIXEL_SIZE.y+1.0)))
	{
		
		COLOR.a = 0.0;
	}
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
