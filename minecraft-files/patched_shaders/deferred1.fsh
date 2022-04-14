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

varying vec3 sunVec, upVec, eastVec;

//Uniforms//
uniform int frameCounter;
uniform int isEyeInWater;

uniform float blindFactor, nightVision;
uniform float far, near;
uniform float frameTimeCounter;
uniform float rainStrength;
uniform float shadowFade;
uniform float timeAngle, timeBrightness;
uniform float viewWidth, viewHeight, aspectRatio;
uniform float worldTime;

uniform ivec2 eyeBrightnessSmooth;

uniform vec3 cameraPosition;

uniform mat4 gbufferProjection, gbufferPreviousProjection, gbufferProjectionInverse;
uniform mat4 gbufferModelView, gbufferPreviousModelView, gbufferModelViewInverse;

uniform sampler2D colortex0;
uniform sampler2D colortex3;
uniform sampler2D depthtex0;


uniform sampler2D colortex4;











//Optifine Constants//

const bool colortex4MipmapEnabled = true;








//Common Variables//
float eBS = eyeBrightnessSmooth.y / 240.0;
float sunVisibility  = clamp((dot( sunVec, upVec) + 0.05) * 10.0, 0.0, 1.0);
float moonVisibility = clamp((dot(-sunVec, upVec) + 0.05) * 10.0, 0.0, 1.0);




float frametime = frameTimeCounter * 1.00;


vec2 aoOffsets[4] = vec2[4](
	vec2( 1.0,  0.0),
	vec2( 0.0,  1.0),
	vec2(-1.0,  0.0),
	vec2( 0.0, -1.0)
);

vec2 glowOffsets[16] = vec2[16](
    vec2( 0.0, -1.0),
    vec2(-1.0,  0.0),
    vec2( 1.0,  0.0),
    vec2( 0.0,  1.0),
    vec2(-1.0, -2.0),
    vec2( 0.0, -2.0),
    vec2( 1.0, -2.0),
    vec2(-2.0, -1.0),
    vec2( 2.0, -1.0),
    vec2(-2.0,  0.0),
    vec2( 2.0,  0.0),
    vec2(-2.0,  1.0),
    vec2( 2.0,  1.0),
    vec2(-1.0,  2.0),
    vec2( 0.0,  2.0),
    vec2( 1.0,  2.0)
);

vec3 lightVec = sunVec * ((timeAngle < 0.5325 || timeAngle > 0.9675) ? 1.0 : -1.0);

//Common Functions//
float GetLuminance(vec3 color) {
	return dot(color,vec3(0.299, 0.587, 0.114));
}

float GetLinearDepth(float depth) {
   return (2.0 * near) / (far + near - depth * (far - near));
}

float InterleavedGradientNoise() {
	float n = 52.9829189 * fract(0.06711056 * gl_FragCoord.x + 0.00583715 * gl_FragCoord.y);
	return fract(n + frameCounter / 8.0);
}


float GetAmbientOcclusion(float z){
	float ao = 0.0;
	float tw = 0.0;
	float lz = GetLinearDepth(z);
	
	for(int i = 0; i < 4; i++){
		vec2 offset = aoOffsets[i] / vec2(viewWidth, viewHeight);
		float samplez = GetLinearDepth(texture2D(depthtex0, texCoord + offset * 3.0).r);
		float wg = max(1.0 - 2.0 * far * abs(lz - samplez), 0.00001);
		ao += texture2DLod(colortex4, texCoord + offset * 2.0, 1.0).r * wg;
		tw += wg;
	}
	ao /= tw;
	if(tw < 0.0001) ao = texture2DLod(colortex4, texCoord, 2.0).r;
	//if(sin(frameTimeCounter*2.0)+0.5>texCoord.x) ao = 1.0;
	
	//return pow(texture2DLod(colortex4, texCoord, 2.0).r, AO_STRENGTH);
	return pow(ao, 1.00);
}


void GlowOutline(inout vec3 color){
	for(int i = 0; i < 16; i++){
		vec2 glowOffset = glowOffsets[i] / vec2(viewWidth, viewHeight);
		float glowSample = texture2D(colortex3, texCoord.xy + glowOffset).b;
		if(glowSample < 0.5){
			if(i < 4) color.rgb = vec3(0.0);
			else color.rgb = vec3(0.5);
			break;
		}
	}
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


















    
    
        
        
    
    














vec3 minLightColSqrt = vec3(128, 128, 128) * 0.70 / 255.0;
vec3 minLightCol	 = minLightColSqrt * minLightColSqrt * 0.04;







vec3 skyColSqrt = vec3(96, 160, 255) * 1.00 / 255.0;
vec3 skyCol = skyColSqrt * skyColSqrt;
vec3 fogCol = skyColSqrt * skyColSqrt;

vec3 blocklightColSqrt = vec3(255, 208, 160) * 0.85 / 255.0;
vec3 blocklightCol = blocklightColSqrt * blocklightColSqrt;
vec4 waterColorSqrt = vec4(vec3(128, 196, 255) / 255.0, 1.0) * 0.30;
vec4 waterColor = waterColorSqrt * waterColorSqrt;

const float waterAlpha = 0.70;
const float waterFogRange = 64.0 / 1.00;
//Dithering from Jodie
float Bayer2(vec2 a) {
    a = floor(a);
    return fract(dot(a, vec2(0.5, a.y * 0.75)));
}









vec3 GetSkyColor(vec3 viewPos, bool isReflection) {
    vec3 nViewPos = normalize(viewPos);

    float VoU = clamp(dot(nViewPos,  upVec), -1.0, 1.0);
    float VoL = clamp(dot(nViewPos, sunVec), -1.0, 1.0);

    float groundDensity = 0.08 * (4.0 - 3.0 * sunVisibility) *
                          (10.0 * rainStrength * rainStrength + 1.0);
    
    float exposure = exp2(timeBrightness * 0.75 - 0.75 + 0.00);
    float nightExposure = exp2(-3.5 + 0.00);
    float weatherExposure = exp2(0.00);

    float gradientCurve = mix(1.50, 1.00, VoL);
    float baseGradient = exp(-(1.0 - pow(1.0 - max(VoU, 0.0), gradientCurve)) /
                             (0.35 + 0.025));

    
    float groundVoU = clamp(-VoU * 1.015 - 0.015, 0.0, 1.0);
    float ground = 1.0 - exp(-groundDensity * max(1.00, 0.125) / groundVoU);
    
    
    
    
    
    

    vec3 sky = skyCol * baseGradient / (1.00 * 1.00);
    
    
    
    sky = sky / sqrt(sky * sky + 1.0) * exposure * sunVisibility * (1.00 * 1.00);

    float sunMix = (VoL * 0.5 + 0.5) * pow(clamp(1.0 - VoU, 0.0, 1.0), 2.0 - sunVisibility) *
                   pow(1.0 - timeBrightness * 0.6, 3.0);
    float horizonMix = pow(1.0 - abs(VoU), 2.5) * 0.125 * (1.0 - timeBrightness * 0.5);
    float lightMix = (1.0 - (1.0 - sunMix) * (1.0 - horizonMix));

    vec3 lightSky = pow(lightSun, vec3(4.0 - sunVisibility)) * baseGradient;
    lightSky = lightSky / (1.0 + lightSky * rainStrength);

    sky = mix(
        sqrt(sky * (1.0 - lightMix)), 
        sqrt(lightSky), 
        lightMix
    );
    sky *= sky;

    float nightGradient = exp(-max(VoU, 0.0) / 0.65);
    vec3 nightSky = lightNight * lightNight * nightGradient * nightExposure;
    sky = mix(nightSky, sky, sunVisibility * sunVisibility);

    float rainGradient = exp(-max(VoU, 0.0) / 1.50);
    vec3 weatherSky = weatherCol.rgb * weatherCol.rgb * weatherExposure;
    weatherSky *= GetLuminance(ambientCol / (weatherSky)) * (0.2 * sunVisibility + 0.2);
    sky = mix(sky, weatherSky * rainGradient, rainStrength);

    sky *= ground;

    if (cameraPosition.y < 1.0) sky *= exp(2.0 * cameraPosition.y - 2.0);

    return sky;
}



vec3 GetFogColor(vec3 viewPos) {
	vec3 nViewPos = normalize(viewPos);
	float lViewPos = length(viewPos) / 64.0;
	lViewPos = 1.0 - exp(-lViewPos * lViewPos);

    float VoU = clamp(dot(nViewPos,  upVec), -1.0, 1.0);
    float VoL = clamp(dot(nViewPos, sunVec), -1.0, 1.0);

	float density = 0.4;
    float nightDensity = 0.65;
    float weatherDensity = 1.5;
    float groundDensity = 0.08 * (4.0 - 3.0 * sunVisibility) *
                          (10.0 * rainStrength * rainStrength + 1.0);
    
    float exposure = exp2(timeBrightness * 0.75 - 1.00);
    float nightExposure = exp2(-3.5);

	float baseGradient = exp(-(VoU * 0.5 + 0.5) * 0.5 / density);

	float groundVoU = clamp(-VoU * 0.5 + 0.5, 0.0, 1.0);
    float ground = 1.0 - exp(-groundDensity / groundVoU);

    vec3 fog = fogCol * baseGradient / (1.00 * 1.00);
    fog = fog / sqrt(fog * fog + 1.0) * exposure * sunVisibility * (1.00 * 1.00);

	float sunMix = (VoL * 0.5 + 0.5) * pow(clamp(1.0 - VoU, 0.0, 1.0), 2.0 - sunVisibility) *
                   pow(1.0 - timeBrightness * 0.6, 3.0);
    float horizonMix = pow(1.0 - abs(VoU), 2.5) * 0.125 * (1.0 - timeBrightness * 0.5);
    float lightMix = (1.0 - (1.0 - sunMix) * (1.0 - horizonMix)) * lViewPos;

	vec3 lightFog = pow(lightSun, vec3(4.0 - sunVisibility)) * baseGradient;
	lightFog = lightFog / (1.0 + lightFog * rainStrength);

    fog = mix(
        sqrt(fog * (1.0 - lightMix)), 
        sqrt(lightFog), 
        lightMix
    );
    fog *= fog;

	float nightGradient = exp(-(VoU * 0.5 + 0.5) * 0.35 / nightDensity);
    vec3 nightFog = lightNight * lightNight * nightGradient * nightExposure;
    fog = mix(nightFog, fog, sunVisibility * sunVisibility);

    float rainGradient = exp(-(VoU * 0.5 + 0.5) * 0.125 / weatherDensity);
    vec3 weatherFog = weatherCol.rgb * weatherCol.rgb;
    weatherFog *= GetLuminance(ambientCol / (weatherFog)) * (0.2 * sunVisibility + 0.2);
    fog = mix(fog, weatherFog * rainGradient, rainStrength);

    if (cameraPosition.y < 1.0) fog *= exp(2.0 * cameraPosition.y - 2.0);

	return fog;
}


void NormalFog(inout vec3 color, vec3 viewPos) {
	
	
	float fogFactor = length(viewPos);
	
	
	
	
	
	
	
	
	float fog = length(viewPos) * 1.00 / 256.0;
	float clearDay = sunVisibility * (1.0 - rainStrength);
	fog *= (0.5 * rainStrength + 1.0) / (4.0 * clearDay + 1.0);
	fog = 1.0 - exp(-2.0 * pow(fog, 0.15 * clearDay + 1.25) * eBS);
	vec3 fogColor = GetFogColor(viewPos);

	
	
		
		
	
		
			
			

			
			
			
			
		
	
	
	

	
	
	
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	

	color = mix(color, fogColor, fog);
}

void BlindFog(inout vec3 color, vec3 viewPos) {
	float fog = length(viewPos) * (blindFactor * 0.2);
	fog = (1.0 - exp(-6.0 * fog * fog * fog)) * blindFactor;
	color = mix(color, vec3(0.0), fog);
}

vec3 denseFogColor[2] = vec3[2](
	vec3(1.0, 0.3, 0.01),
	vec3(0.1, 0.16, 0.2)
);

void DenseFog(inout vec3 color, vec3 viewPos) {
	float fog = length(viewPos) * 0.5;
	fog = (1.0 - exp(-4.0 * fog * fog * fog));
	color = mix(color, denseFogColor[isEyeInWater - 2], fog);
}

void Fog(inout vec3 color, vec3 viewPos) {
	NormalFog(color, viewPos);
	if (isEyeInWater > 1) DenseFog(color, viewPos);
	if (blindFactor > 0.0) BlindFog(color, viewPos);
}



    
    
    
    
    
    
    
    
    
    
    
    






    
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    

    


	
	

	
	

    
	
	

	
		
        

        
            
            

            
            
                
            
            

            
            
            
            
            
            
            
        

        
        
        
        
        
        
        
        
	
    
    
    

    
    
    

	
	

	
		
		
            
            
        
	

	
    






    
    



    
    
    
    
    
    
    


    



    



	



			  
	
	
	
	
	
	

	

    
    
	

    

    
        
		

		
        
		

        
		
			
			
			
			
		
        
        
		
    

	

	
	
	
	
	
	

	
	
	
	
	

	


    
    
    
    
    
    
    
    
    



    
    
    
    
    
    
    
    
    



    
    
    
    

    
    
    

    
    
    
     
    
    
    
    
    
    

    


                  
    

    
    
    
    

	

	








    
	

    
	
	
	
		
		
		
		
		
		

		
			
			
			
			
			
			
			
			
			
		
			
				
					
					
					
					
						

						
						
						
						
						
						
						

						
						
					
				
			
			
		

		
		
		
		
	
	
    



	
	

	
	
	
	
	

	
	

	



	
	
	

	
	
	

	
	
	
	
	
	
	

	
		
		
	

	

	
		
		
			
			
			

			

			
			
			
			
			

			
			

			
		
		
		
		
			
			
			
		
		
		
	
	
	
	
	



	



	
	
	
	
	
	
	
	
	
	
	
		
		
		
	
	

	
		
	









	
		  

	

	



	
	
	
	
	
	

	

	

	
	
	

	
		
		
	

	

	
		
		
			

			
			

			
			
			
				
				
				
				

				
				
			
			
		
	
	

	





//Program//
void main() {
    vec4 color      = texture2D(colortex0, texCoord);
	float z         = texture2D(depthtex0, texCoord).r;

	float dither = (((((Bayer2( 0.5 * (0.5 *(0.5 *(0.5 *(0.5 *(gl_FragCoord.xy)))))) * 0.25 + Bayer2(0.5 *(0.5 *(0.5 *(0.5 *(gl_FragCoord.xy)))))) * 0.25 + Bayer2(0.5 *(0.5 *(0.5 *(gl_FragCoord.xy))))) * 0.25 + Bayer2(0.5 *(0.5 *(gl_FragCoord.xy)))) * 0.25 + Bayer2(0.5 *(gl_FragCoord.xy))) * 0.25 + Bayer2(gl_FragCoord.xy));

	
	if (z == 1.0) color.rgb = max(color.rgb - dither / vec3(64.0), vec3(0.0));
	color.rgb = pow(color.rgb, vec3(2.2));
	
	
	vec4 screenPos = vec4(texCoord, z, 1.0);
	vec4 viewPos = gbufferProjectionInverse * (screenPos * 2.0 - 1.0);
	viewPos /= viewPos.w;

	
	
	

	
	

	if (z < 1.0) {
		
		
		

		

		
			
			
			
			
			
			

			
				
				
				
				
				
				
				
				
				

				
				
				

				
				
				
				

				
				
				
									   
				

				
					
					
					
				
				
				
				
				
				
				
				
			

			
			
			
		
		

		
		color.rgb *= GetAmbientOcclusion(z);
		

		Fog(color.rgb, viewPos.xyz);
	} else {
		
		
		
		
		
		
		
		

		if (isEyeInWater == 2) {
			
			
			
			color.rgb = vec3(1.0, 0.3, 0.01);
			
		}

		if (blindFactor > 0.0) color.rgb *= 1.0 - blindFactor;
	}

	
	
	

	
	float isGlowing = texture2D(colortex3, texCoord).b;
	if (isGlowing > 0.5) GlowOutline(color.rgb);
	

	vec3 reflectionColor = pow(color.rgb, vec3(0.125)) * 0.5;

	
	color.rgb = pow(color.rgb, vec3(1.0 / 2.2));
	
    
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = color;
	
	/*DRAWBUFFERS:05*/
	gl_FragData[1] = vec4(reflectionColor, float(z < 1.0));
	
}



//Vertex Shader/////////////////////////////////////////////////////////////////////////////////////














	
	
	

	
	
	
	

	
	

