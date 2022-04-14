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
uniform float frameTimeCounter;
uniform float rainStrength;
uniform float timeAngle, timeBrightness;
uniform float viewWidth, viewHeight, aspectRatio;

uniform ivec2 eyeBrightnessSmooth;

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;
uniform sampler2D noisetex;
uniform sampler2D depthtex0;






uniform vec3 sunPosition;
uniform mat4 gbufferProjection;


//Optifine Constants//
const bool colortex2Clear = false;





//Common Variables//
float eBS = eyeBrightnessSmooth.y / 240.0;
float sunVisibility  = clamp((dot( sunVec, upVec) + 0.05) * 10.0, 0.0, 1.0);
float moonVisibility = clamp((dot(-sunVec, upVec) + 0.05) * 10.0, 0.0, 1.0);
float pw = 1.0 / viewWidth;
float ph = 1.0 / viewHeight;

//Common Functions//
float GetLuminance(vec3 color) {
	return dot(color, vec3(0.299, 0.587, 0.114));
}

void UnderwaterDistort(inout vec2 texCoord) {
	vec2 originalTexCoord = texCoord;

	texCoord += vec2(
		cos(texCoord.y * 32.0 + frameTimeCounter * 3.0),
		sin(texCoord.x * 32.0 + frameTimeCounter * 1.7)
	) * 0.0005;

	float mask = float(
		texCoord.x > 0.0 && texCoord.x < 1.0 &&
	    texCoord.y > 0.0 && texCoord.y < 1.0
	)
	;
	if (mask < 0.5) texCoord = originalTexCoord;
}

void RetroDither(inout vec3 color, float dither) {
	color.rgb = pow(color.rgb, vec3(0.25));
	float lenColor = length(color);
	vec3 normColor = color / lenColor;

	dither = mix(dither, 0.5, exp(-2.0 * lenColor)) - 0.25;
	color = normColor * floor(lenColor * 4.0 + dither * 1.7) / 4.0;

	color = max(pow(color.rgb, vec3(4.0)), vec3(0.0));
}

vec3 GetBloomTile(float lod, vec2 coord, vec2 offset) {
	float scale = exp2(lod);
	float resScale = 1.25 * min(360.0, viewHeight) / viewHeight;
	vec2 centerOffset = vec2(0.125 * pw, 0.125 * ph);
	vec3 bloom = texture2D(colortex1, (coord / scale + offset) * resScale + centerOffset).rgb;
	return pow(bloom, vec3(4.0)) * 32.0;
}

void Bloom(inout vec3 color, vec2 coord) {
	vec3 blur1 = GetBloomTile(1.0, coord, vec2(0.0      , 0.0   )) * 1.5;
	vec3 blur2 = GetBloomTile(2.0, coord, vec2(0.51     , 0.0   )) * 1.2;
	vec3 blur3 = GetBloomTile(3.0, coord, vec2(0.51     , 0.26  ));
	vec3 blur4 = GetBloomTile(4.0, coord, vec2(0.645    , 0.26  ));
	vec3 blur5 = GetBloomTile(5.0, coord, vec2(0.7175   , 0.26  ));
	vec3 blur6 = GetBloomTile(6.0, coord, vec2(0.645    , 0.3325)) * 0.9;
	vec3 blur7 = GetBloomTile(7.0, coord, vec2(0.670625 , 0.3325)) * 0.7;
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	vec3 blur = (blur1 + blur2 + blur3 + blur4 + blur5 + blur6 + blur7) * 0.137;
	

	
	color = mix(color, blur, 0.2 * 1.00);
	
	
	
	
	
	
	
	
}

void AutoExposure(inout vec3 color, inout float exposure, float tempExposure) {
	float exposureLod = log2(viewHeight * 0.7);
	
	exposure = length(texture2DLod(colortex0, vec2(0.5), exposureLod).rgb);
	exposure = clamp(exposure, 0.0001, 10.0);
	
	color /= 2.0 * clamp(tempExposure, 0.001, 10.0) + 0.125;
}

void ColorGrading(inout vec3 color) {
	vec3 cgColor = pow(color.r, 1.00) * pow(vec3(255, 0, 0) / 255.0, vec3(2.2)) +
				   pow(color.g, 1.00) * pow(vec3(0, 255, 0) / 255.0, vec3(2.2)) +
				   pow(color.b, 1.00) * pow(vec3(0, 0, 255) / 255.0, vec3(2.2));
	vec3 cgMin = pow(vec3(0, 0, 0) / 255.0, vec3(2.2));
	color = (cgColor * (1.0 - cgMin) + cgMin) * vec3(1.00, 1.00, 1.00);
	
	vec3 cgTint = pow(vec3(255, 255, 255) / 255.0, vec3(2.2)) * GetLuminance(color) * 1.00;
	color = mix(color, cgTint, 0.0);
}

void BSLTonemap(inout vec3 color) {
	color = color * exp2(2.0 + 0.00);
	color = color / pow(pow(color, vec3(2.0)) + 1.0, vec3(1.0 / 2.0));
	color = pow(color, mix(vec3(1.0), vec3(1.0), sqrt(color)));
}

void ColorSaturation(inout vec3 color) {
	float grayVibrance = (color.r + color.g + color.b) / 3.0;
	float graySaturation = grayVibrance;
	if (1.00 < 1.00) graySaturation = dot(color, vec3(0.299, 0.587, 0.114));

	float mn = min(color.r, min(color.g, color.b));
	float mx = max(color.r, max(color.g, color.b));
	float sat = (1.0 - (mx - mn)) * (1.0 - mx) * grayVibrance * 5.0;
	vec3 lightness = vec3((mn + mx) * 0.5);

	color = mix(color, mix(color, lightness, 1.0 - 1.00), sat);
	color = mix(color, lightness, (1.0 - lightness) * (2.0 - 1.00) / 2.0 * abs(1.00 - 1.0));
	color = color * 1.00 - graySaturation * (1.00 - 1.0);
}


vec2 GetLightPos() {
	vec4 tpos = gbufferProjection * vec4(sunPosition, 1.0);
	tpos.xyz /= tpos.w;
	return tpos.xy / tpos.z * 0.5;
}


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


float fovmult = gbufferProjection[1][1] / 1.37373871;

float BaseLens(vec2 lightPos, float size, float dist, float hardness) {
	vec2 lensCoord = (texCoord + (lightPos * dist - 0.5)) * vec2(aspectRatio,1.0);
	float lens = clamp(1.0 - length(lensCoord) / (size * fovmult), 0.0, 1.0 / hardness) * hardness;
	lens *= lens; lens *= lens;
	return lens;
}

float OverlapLens(vec2 lightPos, float size, float dista, float distb) {
	return BaseLens(lightPos, size, dista, 2.0) * BaseLens(lightPos, size, distb, 2.0);
}

float PointLens(vec2 lightPos, float size, float dist) {
	return BaseLens(lightPos, size, dist, 1.5) + BaseLens(lightPos, size * 4.0, dist, 1.0) * 0.5;
}

float RingLensTransform(float lensFlare) {
	return pow(1.0 - pow(1.0 - pow(lensFlare, 0.25), 10.0), 5.0);
}
float RingLens(vec2 lightPos, float size, float distA, float distB) {
	float lensFlare1 = RingLensTransform(BaseLens(lightPos, size, distA, 1.0));
	float lensFlare2 = RingLensTransform(BaseLens(lightPos, size, distB, 1.0));
	
	float lensFlare = clamp(lensFlare2 - lensFlare1, 0.0, 1.0);
	lensFlare *= sqrt(lensFlare);
	return lensFlare;
}

float AnamorphicLens(vec2 lightPos, float size, float dist) {
	vec2 lensCoord = abs(texCoord + (lightPos.xy * dist - 0.5)) * vec2(aspectRatio * 0.07, 2.0);
	float lens = clamp(1.0 - length(pow(lensCoord / (size * fovmult), vec2(0.85))) * 4.0, 0.0, 1.0);
	lens *= lens * lens;
	return lens;
}

vec3 RainbowLens(vec2 lightPos, float size, float dist, float rad) {
	vec2 lensCoord = (texCoord + (lightPos * dist - 0.5)) * vec2(aspectRatio,1.0);
	float lens = clamp(1.0 - length(lensCoord) / (size * fovmult), 0.0, 1.0);
	
	vec3 rainbowLens = 
		(smoothstep(0.0, rad, lens) - smoothstep(rad, rad * 2.0, lens)) * vec3(1.0, 0.0, 0.0) +
		(smoothstep(rad * 0.5, rad * 1.5, lens) - smoothstep(rad * 1.5, rad * 2.5, lens)) * vec3(0.0, 1.0, 0.0) +
		(smoothstep(rad, rad * 2.0, lens) - smoothstep(rad * 2.0, rad * 3.0, lens)) * vec3(0.0, 0.0, 1.0)
	;

	return rainbowLens;
}

vec3 LensTint(vec3 lens, float truePos) {
	float isMoon = truePos * 0.5 + 0.5;

	float visibility = mix(sunVisibility,moonVisibility, isMoon);
	lens = mix(lens, GetLuminance(lens) * lightNight * 0.5, isMoon * 0.98);
	return lens * visibility;
}

void LensFlare(inout vec3 color, vec2 lightPos, float truePos, float multiplier) {
	float falloffBase = length(lightPos * vec2(aspectRatio, 1.0));
	float falloffIn = pow(clamp(falloffBase * 10.0, 0.0, 1.0), 2.0);
	float falloffOut = clamp(falloffBase * 3.0 - 1.5, 0.0, 1.0);

	if (falloffOut < 0.999) {
		vec3 lensFlare = (
			BaseLens(lightPos, 0.3, -0.45, 1.0) * vec3(2.2, 1.2, 0.1) * 0.07 +
			BaseLens(lightPos, 0.3,  0.10, 1.0) * vec3(2.2, 0.4, 0.1) * 0.03 +
			BaseLens(lightPos, 0.3,  0.30, 1.0) * vec3(2.2, 0.2, 0.1) * 0.04 +
			BaseLens(lightPos, 0.3,  0.50, 1.0) * vec3(2.2, 0.4, 2.5) * 0.05 +
			BaseLens(lightPos, 0.3,  0.70, 1.0) * vec3(1.8, 0.4, 2.5) * 0.06 +
			BaseLens(lightPos, 0.3,  0.95, 1.0) * vec3(0.1, 0.2, 2.5) * 0.10 +
			
			OverlapLens(lightPos, 0.18, -0.30, -0.41) * vec3(2.5, 1.2, 0.1) * 0.010 +
			OverlapLens(lightPos, 0.16, -0.18, -0.29) * vec3(2.5, 0.5, 0.1) * 0.020 +
			OverlapLens(lightPos, 0.15,  0.06,  0.19) * vec3(2.5, 0.2, 0.1) * 0.015 +
			OverlapLens(lightPos, 0.14,  0.15,  0.28) * vec3(1.8, 0.1, 1.2) * 0.015 +
			OverlapLens(lightPos, 0.16,  0.24,  0.37) * vec3(1.0, 0.1, 2.5) * 0.015 +
				
			PointLens(lightPos, 0.03, -0.55) * vec3(2.5, 1.6, 0.0) * 0.20 +
			PointLens(lightPos, 0.02, -0.40) * vec3(2.5, 1.0, 0.0) * 0.15 +
			PointLens(lightPos, 0.04,  0.43) * vec3(2.5, 0.6, 0.6) * 0.20 +
			PointLens(lightPos, 0.02,  0.60) * vec3(0.2, 0.6, 2.5) * 0.15 +
			PointLens(lightPos, 0.03,  0.67) * vec3(0.2, 1.6, 2.5) * 0.25 +
				
			RingLens(lightPos, 0.25, 0.43, 0.45) * vec3(0.10, 0.35, 2.50) * 1.5 +
			RingLens(lightPos, 0.18, 0.98, 0.99) * vec3(0.15, 1.00, 2.55) * 2.5
		) * (falloffIn - falloffOut) + (
			AnamorphicLens(lightPos, 1.0, -1.0) * vec3(0.3,0.7,1.0) * 0.35 +
			RainbowLens(lightPos, 0.525, -1.0, 0.2) * 0.05 +
			RainbowLens(lightPos, 2.0, 4.0, 0.1) * 0.05
		) * (1.0 - falloffOut);

		lensFlare = LensTint(lensFlare, truePos);

		color = mix(color, vec3(1.0), lensFlare * multiplier * multiplier);
	}
}





    
    











//Program//
void main() {
    vec2 newTexCoord = texCoord;
	if (isEyeInWater == 1.0) UnderwaterDistort(newTexCoord);
	
	vec3 color = texture2D(colortex0, newTexCoord).rgb;
	
	
	
	

	
	float tempVisibleSun = texture2D(colortex2, vec2(3.0 * pw, ph)).r;
	

	vec3 temporalColor = vec3(0.0);
	
	
	
	
	
	
	
	
	
	
	Bloom(color, newTexCoord);
	
	
	
	
	
	
	
	
	
	
	
	BSLTonemap(color);
	
	
	vec2 lightPos = GetLightPos();
	float truePos = sign(sunVec.z);
	      
    float visibleSun = float(texture2D(depthtex0, lightPos + 0.5).r >= 1.0);
	visibleSun *= max(1.0 - isEyeInWater, eBS) * (1.0 - blindFactor) * (1.0 - rainStrength);
	
	float multiplier = tempVisibleSun * 1.00 * 0.5;

	if (multiplier > 0.001) LensFlare(color, lightPos, truePos, multiplier);
	
	
	float temporalData = 0.0;
	
	
	
		
	

	
	if (texCoord.x > 2.0 * pw && texCoord.x < 4.0 * pw && texCoord.y < 2.0 * ph)
		temporalData = mix(tempVisibleSun, visibleSun, 0.125);
	
	
    
    color *= 1.0 - length(texCoord - 0.5) * (1.0 - GetLuminance(color));
	
	
	color = pow(color, vec3(1.0 / 2.2));
	
	ColorSaturation(color);
	
	float filmGrain = texture2D(noisetex, texCoord * vec2(viewWidth, viewHeight) / 512.0).b;
	color += (filmGrain - 0.25) / 128.0;
	
	/* DRAWBUFFERS:12 */
	gl_FragData[0] = vec4(color, 1.0);
	gl_FragData[1] = vec4(temporalData,temporalColor);
}



//Vertex Shader/////////////////////////////////////////////////////////////////////////////////////














	
	
	

	
	
	
	

	

