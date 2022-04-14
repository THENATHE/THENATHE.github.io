#version 150 core
#define gl_FragData iris_FragData
#define varying in
#define gl_ModelViewProjectionMatrix (gl_ProjectionMatrix * gl_ModelViewMatrix)
#define gl_ModelViewMatrix mat4(1.0)
#define gl_NormalMatrix mat3(1.0)
#define gl_Color vec4(1.0, 1.0, 1.0, 1.0)
#define gl_ProjectionMatrix mat4(vec4(2.0, 0.0, 0.0, 0.0), vec4(0.0, 2.0, 0.0, 0.0), vec4(0.0), vec4(-1.0, -1.0, 0.0, 1.0))
#define gl_FogFragCoord iris_FogFragCoord
uniform float iris_FogDensity;
uniform float iris_FogStart;
uniform float iris_FogEnd;
uniform vec4 iris_FogColor;

struct iris_FogParameters {
    vec4 color;
    float density;
    float start;
    float end;
    float scale;
};

iris_FogParameters iris_Fog = iris_FogParameters(iris_FogColor, iris_FogDensity, iris_FogStart, iris_FogEnd, 1.0 / (iris_FogEnd - iris_FogStart));

#define gl_Fog iris_Fog
in float iris_FogFragCoord;
out vec4 iris_FragData[8];
vec4 texture2D(sampler2D sampler, vec2 coord) { return texture(sampler, coord); }
vec4 texture2D(sampler2D sampler, vec2 coord, float bias) { return texture(sampler, coord, bias); }
vec4 texture2DLod(sampler2D sampler, vec2 coord, float lod) { return textureLod(sampler, coord, lod); }
vec4 shadow2D(sampler2DShadow sampler, vec3 coord) { return vec4(texture(sampler, coord)); }
vec4 shadow2DLod(sampler2DShadow sampler, vec3 coord, float lod) { return vec4(textureLod(sampler, coord, lod)); }
/* 
BSL Shaders v8 Series by Capt Tatsu 
https://bitslablab.com 
*/ 



















































































































































































































































































































































































































/* 
BSL Shaders v8 Series by Capt Tatsu 
https://bitslablab.com 
*/ 

//Settings//
/* 
BSL Shaders v8 Series by Capt Tatsu 
https://bitslablab.com 
*/ 

//Shader Options//

  

//Lighting//
  const int shadowMapResolution = 2048; //[512 1024 2048 3072 4096 8192]
  const float shadowDistance = 256.0; //[128.0 256.0 512.0 1024.0]
  
  
  const float sunPathRotation = -40.0; //[-60.0 -55.0 -50.0 -45.0 -40.0 -35.0 -30.0 -25.0 -20.0 -15.0 -10.0 -5.0 0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0]
  
  const float shadowMapBias = 1.0 - 25.6 / shadowDistance;
  
  
  
  
//#define DYNAMIC_HANDLIGHT
//#define TOON_LIGHTMAP
//#define WHITE_WORLD

//Material//
//#define ADVANCED_MATERIALS
  

  
  
  
  
  
//#define REFLECTION_PREVIOUS
//#define SPECULAR_HIGHLIGHT_ROUGH
//#define ALBEDO_METAL

  
  
  
  
  
  
  
//#define DIRECTIONAL_LIGHTMAP
  
  
  

  
  
  
  
  

//Atmospherics//
  
  
  
//#define AURORA
//#define ROUND_SUN_MOON
  
  
  
  
  
  
  
  

  
  
  
  
  
  
  
  
  
  

  
  
  
  
  
  

//Water//
  
  
  
  
  
  
  
  
  
  

//Post Effects//
//#define DOF
  
//#define MOTION_BLUR
  
  
  
  
  
  
  
  
//#define TAA
  
//#define DIRTY_LENS
  
//#define RETRO_FILTER
  

//Tonemap & Color Grading//
  
//#define AUTO_EXPOSURE

//#define COLOR_GRADING

  
  
  
  
  
  
  
  
  
  

  
  

  
  
  
  
  
  

  
  
  
  
  
  

  
  
  
  
  
  

  
  
  
  
  

//Color//
  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  

  
  
  
  
  
//#define SKY_VANILLA
//#define NETHER_VANILLA
//#define EMISSIVE_RECOLOR

//World//
  
//#define WORLD_CURVATURE
  
//#define WORLD_TIME_ANIMATION
  

//Waving//
  
  
  
  

//Undefine//
  
  
  
  
  
  

  
  
  
  

//Outline Params//
  
  
  

  
  
  

  
  
  
  
  
  
  
  
  
  
  
  
  
  

//Retro Filter Removes AA//
  
  
  
  

//Normal Skip for 1.15 - 1.16 G7
  
  
  

//Fragment Shader///////////////////////////////////////////////////////////////////////////////////


//Varyings//
varying vec2 texCoord;

//Uniforms//
uniform float viewWidth, viewHeight, aspectRatio, frameTimeCounter;

uniform sampler2D colortex0;

//Optifine Constants//
const bool colortex0MipmapEnabled = true;

//Common Variables//
float ph = 0.8 / min(360.0, viewHeight);
float pw = ph / aspectRatio;

float weight[5] = float[5](1.0, 4.0, 6.0, 4.0, 1.0);

//Common Functions//
vec3 BloomTile(float lod, vec2 coord, vec2 offset) {
	vec3 bloom = vec3(0.0), temp = vec3(0.0);
	float scale = exp2(lod);
	coord = (coord - offset) * scale;
	float padding = 0.5 + 0.005 * scale;

	if (abs(coord.x - 0.5) < padding && abs(coord.y - 0.5) < padding) {
		for(int i = 0; i < 5; i++) {
			for(int j = 0; j < 5; j++) {
				float wg = weight[i] * weight[j];
				vec2 pixelOffset = vec2((float(i) - 2.0) * pw, (float(j) - 2.0) * ph);
				vec2 sampleCoord = coord + pixelOffset * scale;
				bloom += texture2D(colortex0, sampleCoord).rgb * wg;
			}
		}
		bloom /= 256.0;
	}

	return pow(bloom / 32.0, vec3(0.25));
}

//Dithering from Jodie
float Bayer2(vec2 a) {
    a = floor(a);
    return fract(dot(a, vec2(0.5, a.y * 0.75)));
}









//Program//
void main() {
	vec2 bloomCoord = texCoord * viewHeight * 0.8 / min(360.0, viewHeight);
	vec3 blur =  BloomTile(1.0, bloomCoord, vec2(0.0      , 0.0   ));
	     blur += BloomTile(2.0, bloomCoord, vec2(0.51     , 0.0   ));
	     blur += BloomTile(3.0, bloomCoord, vec2(0.51     , 0.26  ));
	     blur += BloomTile(4.0, bloomCoord, vec2(0.645    , 0.26  ));
	     blur += BloomTile(5.0, bloomCoord, vec2(0.7175   , 0.26  ));
	     blur += BloomTile(6.0, bloomCoord, vec2(0.645    , 0.3325));
	     blur += BloomTile(7.0, bloomCoord, vec2(0.670625 , 0.3325));
		
		 blur = clamp(blur + ((((((Bayer2( 0.5 * (0.5 *(0.5 *(0.5 *(0.5 *(gl_FragCoord.xy)))))) * 0.25 + Bayer2(0.5 *(0.5 *(0.5 *(0.5 *(gl_FragCoord.xy)))))) * 0.25 + Bayer2(0.5 *(0.5 *(0.5 *(gl_FragCoord.xy))))) * 0.25 + Bayer2(0.5 *(0.5 *(gl_FragCoord.xy)))) * 0.25 + Bayer2(0.5 *(gl_FragCoord.xy))) * 0.25 + Bayer2(gl_FragCoord.xy)) - 0.5) / 384.0, vec3(0.0), vec3(1.0));

    /* DRAWBUFFERS:1 */
	gl_FragData[0] = vec4(blur, 1.0);
}



//Vertex Shader/////////////////////////////////////////////////////////////////////////////////////







	
	
	





