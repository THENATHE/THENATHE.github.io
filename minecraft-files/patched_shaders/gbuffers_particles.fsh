#version 150 core
#define gl_FragData iris_FragData
#define varying in
#define gl_ModelViewProjectionMatrix (gl_ProjectionMatrix * gl_ModelViewMatrix)
#define gl_ModelViewMatrix (iris_ModelViewMat * _iris_internal_translate(iris_ChunkOffset))
#define gl_NormalMatrix mat3(transpose(inverse(gl_ModelViewMatrix)))
#define gl_Color (Color * iris_ColorModulator)
#define gl_ProjectionMatrix iris_ProjMat
#define gl_FogFragCoord iris_FogFragCoord
uniform mat4 iris_LightmapTextureMatrix;
uniform mat4 iris_TextureMat;
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
uniform mat4 iris_ProjMat;
uniform vec4 iris_ColorModulator;
uniform mat4 iris_ModelViewMat;
uniform vec3 iris_ChunkOffset;
mat4 _iris_internal_translate(vec3 offset) {
    // NB: Column-major order
    return mat4(1.0, 0.0, 0.0, 0.0,
                0.0, 1.0, 0.0, 0.0,
                0.0, 0.0, 1.0, 0.0,
                offset.x, offset.y, offset.z, 1.0);
}
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
varying vec2 texCoord, lmCoord;

varying vec3 normal;
varying vec3 sunVec, upVec, eastVec;

varying vec4 color;

//Uniforms//
uniform int frameCounter;
uniform int isEyeInWater;
uniform int worldTime;

uniform float blindFactor, nightVision;
uniform float far, near;
uniform float frameTimeCounter;
uniform float rainStrength;
uniform float screenBrightness; 
uniform float shadowFade;
uniform float timeAngle, timeBrightness;
uniform float viewWidth, viewHeight;

uniform ivec2 eyeBrightnessSmooth;

uniform vec3 cameraPosition;

uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferModelViewInverse;
uniform mat4 shadowProjection;
uniform mat4 shadowModelView;

uniform sampler2D texture;










//Common Variables//
float eBS = eyeBrightnessSmooth.y / 240.0;
float sunVisibility  = clamp((dot( sunVec, upVec) + 0.05) * 10.0, 0.0, 1.0);
float moonVisibility = clamp((dot(-sunVec, upVec) + 0.05) * 10.0, 0.0, 1.0);




float frametime = frameTimeCounter * 1.00;


vec3 lightVec = sunVec * ((timeAngle < 0.5325 || timeAngle > 0.9675) ? 1.0 : -1.0);

//Common Functions//
float GetLuminance(vec3 color) {
	return dot(color,vec3(0.299, 0.587, 0.114));
}

float InterleavedGradientNoise() {
	float n = 52.9829189 * fract(0.06711056 * gl_FragCoord.x + 0.00583715 * gl_FragCoord.y);
	return fract(n + frameCounter / 8.0);
}



   



//Includes//
vec3 blocklightColSqrt = vec3(255, 208, 160) * 0.85 / 255.0;
vec3 blocklightCol = blocklightColSqrt * blocklightColSqrt;

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

//Dithering from Jodie
float Bayer2(vec2 a) {
    a = floor(a);
    return fract(dot(a, vec2(0.5, a.y * 0.75)));
}











vec3 ToNDC(vec3 pos) {
	vec4 iProjDiag = vec4(gbufferProjectionInverse[0].x,
						  gbufferProjectionInverse[1].y,
						  gbufferProjectionInverse[2].zw);
    vec3 p3 = pos * 2.0 - 1.0;
    vec4 viewPos = iProjDiag * p3.xyzz + gbufferProjectionInverse[3];
    return viewPos.xyz / viewPos.w;
}

vec3 ToWorld(vec3 pos) {
	return mat3(gbufferModelViewInverse) * pos + gbufferModelViewInverse[3].xyz;
}

vec3 ToShadow(vec3 pos) {
	vec3 shadowpos = mat3(shadowModelView) * pos + shadowModelView[3].xyz;
	return (vec3((shadowProjection)[0].x, (shadowProjection)[1].y, shadowProjection[2].z) * (shadowpos) + (shadowProjection)[3].xyz);
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

uniform sampler2DShadow shadowtex0;


uniform sampler2DShadow shadowtex1;
uniform sampler2D shadowcolor0;


/*
uniform sampler2D shadowtex0;

#ifdef SHADOW_COLOR
uniform sampler2D shadowtex1;
uniform sampler2D shadowcolor0;
#endif
*/

vec2 shadowOffsets[9] = vec2[9](
    vec2( 0.0, 0.0),
    vec2( 0.0, 1.0),
    vec2( 0.7, 0.7),
    vec2( 1.0, 0.0),
    vec2( 0.7,-0.7),
    vec2( 0.0,-1.0),
    vec2(-0.7,-0.7),
    vec2(-1.0, 0.0),
    vec2(-0.7, 0.7)
);

float biasDistribution[10] = float[10](
    0.0, 0.057, 0.118, 0.184, 0.255, 0.333, 0.423, 0.529, 0.667, 1.0
);

/*
float texture2DShadow(sampler2D shadowtex, vec3 shadowPos) {
    float shadow = texture2D(shadowtex,shadowPos.st).x;
    shadow = clamp((shadow-shadowPos.z)*65536.0,0.0,1.0);
    return shadow;
}
*/

vec3 DistortShadow(vec3 worldPos, float distortFactor) {
	worldPos.xy /= distortFactor;
	worldPos.z *= 0.2;
	return worldPos * 0.5 + 0.5;
}

float GetCurvedBias(int i, float dither) {
    return mix(biasDistribution[i], biasDistribution[i+1], dither);
}

vec3 SampleBasicShadow(vec3 shadowPos) {
    float shadow0 = shadow2D(shadowtex0, vec3(shadowPos.st, shadowPos.z)).x;

    vec3 shadowCol = vec3(0.0);
    
    if (shadow0 < 1.0) {
        shadowCol = texture2D(shadowcolor0, shadowPos.st).rgb *
                    shadow2D(shadowtex1, vec3(shadowPos.st, shadowPos.z)).x;
    }
    

    return clamp(shadowCol * (1.0 - shadow0) + shadow0, vec3(0.0), vec3(1.0));
}

vec3 SampleFilteredShadow(vec3 shadowPos, float offset, float biasStep) {
    float shadow0 = 0.0;

    
    
    
    
    
    for (int i = 0; i < 9; i++) {
        vec2 shadowOffset = shadowOffsets[i] * offset;
        shadow0 += shadow2D(shadowtex0, vec3(shadowPos.st + shadowOffset, shadowPos.z)).x;
        
        
        
    }
    shadow0 /= 9.0;

    vec3 shadowCol = vec3(0.0);
    
    if (shadow0 < 0.999) {
        for (int i = 0; i < 9; i++) {
            vec2 shadowOffset = shadowOffsets[i] * offset;
            shadowCol += texture2D(shadowcolor0, shadowPos.st + shadowOffset).rgb *
                         shadow2D(shadowtex1, vec3(shadowPos.st + shadowOffset, shadowPos.z)).x;
            
            
            
        }
        shadowCol /= 9.0;
    }
    

    return clamp(shadowCol * (1.0 - shadow0) + shadow0, vec3(0.0), vec3(1.0));
}

vec3 GetShadow(vec3 worldPos, float NoL, float subsurface, float skylight) {
    
    
               
    
    
    vec3 shadowPos = ToShadow(worldPos);

    float distb = sqrt(dot(shadowPos.xy, shadowPos.xy));
    float distortFactor = distb * shadowMapBias + (1.0 - shadowMapBias);
    shadowPos = DistortShadow(shadowPos, distortFactor);

    bool doShadow = shadowPos.x > 0.0 && shadowPos.x < 1.0 &&
                    shadowPos.y > 0.0 && shadowPos.y < 1.0;

    
    doShadow = doShadow && skylight > 0.001;
    

    if (!doShadow) return vec3(skylight);

    float biasFactor = sqrt(1.0 - NoL * NoL) / NoL;
    float distortBias = distortFactor * shadowDistance / 256.0;
    distortBias *= 8.0 * distortBias;
    float distanceBias = sqrt(dot(worldPos.xyz, worldPos.xyz)) * 0.005;
    
    float bias = (distortBias * biasFactor + distanceBias + 0.05) / shadowMapResolution;
    float offset = 1.0 / shadowMapResolution;
    
    if (subsurface > 0.0) {
        bias = 0.0002;
        
        
        
        offset = 0.0007;
    }
    float biasStep = 0.001 * subsurface * (1.0 - NoL);
    
    
    
    

    shadowPos.z -= bias;

    
    vec3 shadow = SampleFilteredShadow(shadowPos, offset, biasStep);
    
    
    

    return shadow;
}


void GetLighting(inout vec3 albedo, out vec3 shadow, vec3 viewPos, vec3 worldPos,
                 vec2 lightmap, float smoothLighting, float NoL, float vanillaDiffuse,
                 float parallaxShadow, float emission, float subsurface) {
    
    
    

    
    
    

    
    if (NoL > 0.0 || subsurface > 0.0) shadow = GetShadow(worldPos, NoL, subsurface, lightmap.y);
    shadow *= parallaxShadow;
    NoL = clamp(NoL * 1.01 - 0.01, 0.0, 1.0);
    
    float scattering = 0.0;
    if (subsurface > 0.0){
        float VoL = clamp(dot(normalize(viewPos.xyz), lightVec) * 0.5 + 0.5, 0.0, 1.0);
        scattering = pow(VoL, 16.0) * (1.0 - rainStrength) * subsurface;
        NoL = mix(NoL, 1.0, sqrt(subsurface) * 0.7);
        NoL = mix(NoL, 1.0, scattering);
    }
    
    vec3 fullShadow = shadow * NoL;
    
    
    float shadowMult = (1.0 - 0.95 * rainStrength) * shadowFade;
    vec3 sceneLighting = mix(ambientCol, lightCol, fullShadow * shadowMult);
    sceneLighting *= (4.0 - 3.0 * eBS) * lightmap.y * lightmap.y * (1.0 + scattering * shadow);
    

    
    
    

    
    
    
    
    float newLightmap  = pow(lightmap.x, 10.0) * 1.5 + lightmap.x * 0.7;
    vec3 blockLighting = blocklightCol * newLightmap * newLightmap;

    vec3 minLighting = minLightCol * (1.0 - eBS);

    
    
    
    
    
    vec3 albedoNormalized = normalize(albedo.rgb + 0.00001);
    vec3 emissiveLighting = mix(albedoNormalized, vec3(1.0), emission * 0.5);
    emissiveLighting *= emission * 4.0;

    float lightFlatten = clamp(1.0 - pow(1.0 - emission, 128.0), 0.0, 1.0);
    vanillaDiffuse = mix(vanillaDiffuse, 1.0, lightFlatten);
    smoothLighting = mix(smoothLighting, 1.0, lightFlatten);
        
    float nightVisionLighting = nightVision * 0.25;
    
    
    float albedoLength = length(albedo.rgb);
    albedoLength /= sqrt((albedoLength * albedoLength) * 0.25 * (1.0 - lightFlatten) + 1.0);
    albedo.rgb = albedoNormalized * albedoLength;
    

    //albedo = vec3(0.5);
    albedo *= sceneLighting + blockLighting + emissiveLighting + nightVisionLighting + minLighting;
    albedo *= vanillaDiffuse * smoothLighting * smoothLighting;

    
    
    float desatAmount = sqrt(max(sqrt(length(fullShadow / 3.0)) * lightmap.y, lightmap.y)) *
                        sunVisibility * (1.0 - rainStrength * 0.4) + 
                        sqrt(lightmap.x) + lightFlatten;

    vec3 desatNight   = lightNight / 1.00;
    vec3 desatWeather = weatherCol.rgb / weatherCol.a * 0.5;

    desatNight *= desatNight; desatWeather *= desatWeather;
    
    float desatNWMix  = (1.0 - sunVisibility) * (1.0 - rainStrength);

    vec3 desatColor = mix(desatWeather, desatNight, desatNWMix);
    desatColor = mix(vec3(0.1), desatColor, sqrt(lightmap.y)) * 10.0;
    

    
    

    
    

    
    

    
    

    desatAmount = clamp(desatAmount, 1.0 * 0.4, 1.0);
    desatColor *= 1.0 - desatAmount;

    albedo = mix(GetLuminance(albedo) * desatColor, albedo, desatAmount);
    
}






							
							
							
							
							
							
							
							
						
							   

	
	



//Program//
void irisMain() {
    vec4 albedo = texture2D(texture, texCoord) * color;

	if (albedo.a > 0.001) {
		vec2 lightmap = clamp(lmCoord, vec2(0.0), vec2(1.0));

		vec3 screenPos = vec3(gl_FragCoord.xy / vec2(viewWidth, viewHeight), gl_FragCoord.z);
		
		
		
		vec3 viewPos = ToNDC(screenPos);
		
		vec3 worldPos = ToWorld(viewPos);
		
		
		
		
		
		

		
		
		
		

    	albedo.rgb = pow(albedo.rgb, vec3(2.2));

		
		
		

		float NoL = 1.0;
		//NoL = clamp(dot(normal, lightVec) * 1.01 - 0.01, 0.0, 1.0);

		float NoU = clamp(dot(normal, upVec), -1.0, 1.0);
		float NoE = clamp(dot(normal, eastVec), -1.0, 1.0);
		float vanillaDiffuse = (0.25 * NoU + 0.75) + (0.667 - abs(NoE)) * (1.0 - abs(NoU)) * 0.15;
			  vanillaDiffuse*= vanillaDiffuse;
		
		vec3 shadow = vec3(0.0);
		GetLighting(albedo.rgb, shadow, viewPos, worldPos, lightmap, 1.0, NoL, 1.0,
				    1.0, 0.0, 0.0);

		
		
		

		
		albedo.rgb = pow(max(albedo.rgb, vec3(0.0)), vec3(1.0 / 2.2));
		
	}

	
	
	
	

	
	

	

	
	
	
	
    /* DRAWBUFFERS:0 */
    gl_FragData[0] = albedo;

	
	
	
	
	
	
}



//Vertex Shader/////////////////////////////////////////////////////////////////////////////////////












































   



	









							
							
							
							
							
							
							
							
						
							   

	
	





    





	
    
	
	

	
    
	

	
	
	
	

	
	

    
	
	
	
	
	
    

	
	
	
	
	
	
	
	
	





void main() {
    irisMain();

    if (!(gl_FragData[0].a > 0.1)) {
        discard;
    }
}
