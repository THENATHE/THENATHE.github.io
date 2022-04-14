#version 150 core
#define gl_FragData iris_FragData
#define varying in
#define gl_ModelViewProjectionMatrix (gl_ProjectionMatrix * gl_ModelViewMatrix)
#define gl_ModelViewMatrix mat4(1.0)
#define gl_NormalMatrix mat3(1.0)
#define gl_Color vec4(1.0, 1.0, 1.0, 1.0)
#define gl_ProjectionMatrix mat4(vec4(2.0, 0.0, 0.0, 0.0), vec4(0.0, 2.0, 0.0, 0.0), vec4(0.0), vec4(-1.0, -1.0, 0.0, 1.0))
#define gl_FogFragCoord iris_FogFragCoord
#extension  GL_ARB_shader_texture_lod : enable
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

varying vec3 sunVec, upVec;

//Uniforms//
uniform int isEyeInWater;
uniform int worldTime;

uniform float blindFactor;
uniform float rainStrength;
uniform float shadowFade;
uniform float timeAngle, timeBrightness;
uniform float frameTimeCounter;

uniform ivec2 eyeBrightnessSmooth;

uniform vec3 cameraPosition;

uniform sampler2D colortex0;
uniform sampler2D colortex1;

//Optifine Constants//
const bool colortex1MipmapEnabled = true;

//Common Variables//
float eBS = eyeBrightnessSmooth.y / 240.0;
float sunVisibility = clamp(dot(sunVec, upVec) + 0.05, 0.0, 0.1) * 10.0;

//Includes//

vec3 lightMorning    = vec3(255,   160,   80)   * 1.20 / 255.0;
vec3 lightDay        = vec3(192,   216,   255)   * 1.40 / 255.0;
vec3 lightEvening    = vec3(255,   160,   80)   * 1.20 / 255.0;
vec3 lightNight      = vec3(96,   192,   255)   * 1.00 * 0.3 / 255.0;

vec3 ambientMorning  = vec3(255, 204, 144) * 0.40 / 255.0;
vec3 ambientDay      = vec3(120, 172, 255) * 0.60 / 255.0;
vec3 ambientEvening  = vec3(255, 204, 144) * 0.40 / 255.0;
vec3 ambientNight    = vec3(96, 192, 255) * 0.60 * 0.3 / 255.0;


uniform float isDesert, isMesa, isCold, isSwamp, isMushroom, isSavanna;

vec4 weatherRain     = vec4(vec3(176, 224, 255) / 255.0, 1.0) * 1.20;
vec4 weatherCold     = vec4(vec3(216, 240, 255) / 255.0, 1.0) * 1.20;
vec4 weatherDesert   = vec4(vec3(255, 232, 180) / 255.0, 1.0) * 1.20;
vec4 weatherBadlands = vec4(vec3(255, 216, 176) / 255.0, 1.0) * 1.20;
vec4 weatherSwamp    = vec4(vec3(200, 224, 160) / 255.0, 1.0) * 1.20;
vec4 weatherMushroom = vec4(vec3(216, 216, 255) / 255.0, 1.0) * 1.20;
vec4 weatherSavanna  = vec4(vec3(224, 224, 224) / 255.0, 1.0) * 1.20;

float weatherWeight = isCold + isDesert + isMesa + isSwamp + isMushroom + isSavanna;

vec4 weatherCol = mix(
	weatherRain,
	(
		weatherCold  * isCold  + weatherDesert   * isDesert   + weatherBadlands * isMesa    +
		weatherSwamp * isSwamp + weatherMushroom * isMushroom + weatherSavanna  * isSavanna
	) / max(weatherWeight, 0.0001),
	weatherWeight
);





float mefade = 1.0 - clamp(abs(timeAngle - 0.5) * 8.0 - 1.5, 0.0, 1.0);
float dfade = 1.0 - pow(1.0 - timeBrightness, 1.5);

vec3 CalcSunColor(vec3 morning, vec3 day, vec3 evening) {
	vec3 me = mix(morning, evening, mefade);
	return mix(me, day, dfade);
}

vec3 CalcLightColor(vec3 sun, vec3 night, vec3 weatherCol) {
	vec3 c = mix(night, sun, sunVisibility);
	c = mix(c, dot(c, vec3(0.299, 0.587, 0.114)) * weatherCol, rainStrength);
	return c * c;
}

vec3 lightSun   = CalcSunColor(lightMorning, lightDay, lightEvening);
vec3 ambientSun = CalcSunColor(ambientMorning, ambientDay, ambientEvening);

vec3 lightCol   = CalcLightColor(lightSun, lightNight, weatherCol.rgb);
vec3 ambientCol = CalcLightColor(ambientSun, ambientNight, weatherCol.rgb);


















    
    
        
        
    
    














vec3 minLightColSqrt = vec3(128, 128, 128) * 0.70 / 255.0;
vec3 minLightCol	 = minLightColSqrt * minLightColSqrt * 0.04;

//Program//
void main() {
    vec4 color = texture2D(colortex0, texCoord.xy);
	
	vec3 vl = texture2DLod(colortex1, texCoord.xy, 1.5).rgb;
	vl *= vl;

	
    vl *= lightCol * 0.25;
	if (cameraPosition.y < 1.0) vl *= exp(2.0 * cameraPosition.y - 2.0);
	

	
    
	

    vl *= 1.00 * (1.0 - rainStrength * eBS * 0.875) * shadowFade *
		  (1.0 - blindFactor);
	
	color.rgb += vl;
	
	/*DRAWBUFFERS:0*/
	gl_FragData[0] = color;
}



//Vertex Shader/////////////////////////////////////////////////////////////////////////////////////














	
	
	

	
	
	
	

	

