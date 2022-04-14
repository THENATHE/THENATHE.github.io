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

//Uniforms//
uniform float viewWidth, viewHeight, aspectRatio;

uniform sampler2D colortex1;

//Optifine Constants//




//Common Functions//
float GetLuminance(vec3 color) {
	return dot(color, vec3(0.299, 0.587, 0.114));
}

//Includes//
//FXAA 3.11 from http://blog.simonrodriguez.fr/articles/30-07-2016_implementing_fxaa.html
float quality[12] = float[12] (1.0, 1.0, 1.0, 1.0, 1.0, 1.5, 2.0, 2.0, 2.0, 2.0, 4.0, 8.0);

vec3 FXAA311(vec3 color) {
	float edgeThresholdMin = 0.03125;
	float edgeThresholdMax = 0.125;
	float subpixelQuality = 0.75;
	int iterations = 12;
	
	vec2 view = 1.0 / vec2(viewWidth, viewHeight);
	
	float lumaCenter = GetLuminance(color);
	float lumaDown  = GetLuminance(texture2DLod(colortex1, texCoord + vec2( 0.0, -1.0) * view, 0.0).rgb);
	float lumaUp    = GetLuminance(texture2DLod(colortex1, texCoord + vec2( 0.0,  1.0) * view, 0.0).rgb);
	float lumaLeft  = GetLuminance(texture2DLod(colortex1, texCoord + vec2(-1.0,  0.0) * view, 0.0).rgb);
	float lumaRight = GetLuminance(texture2DLod(colortex1, texCoord + vec2( 1.0,  0.0) * view, 0.0).rgb);
	
	float lumaMin = min(lumaCenter, min(min(lumaDown, lumaUp), min(lumaLeft, lumaRight)));
	float lumaMax = max(lumaCenter, max(max(lumaDown, lumaUp), max(lumaLeft, lumaRight)));
	
	float lumaRange = lumaMax - lumaMin;
	
	if (lumaRange > max(edgeThresholdMin, lumaMax * edgeThresholdMax)) {
		float lumaDownLeft  = GetLuminance(texture2DLod(colortex1, texCoord + vec2(-1.0, -1.0) * view, 0.0).rgb);
		float lumaUpRight   = GetLuminance(texture2DLod(colortex1, texCoord + vec2( 1.0,  1.0) * view, 0.0).rgb);
		float lumaUpLeft    = GetLuminance(texture2DLod(colortex1, texCoord + vec2(-1.0,  1.0) * view, 0.0).rgb);
		float lumaDownRight = GetLuminance(texture2DLod(colortex1, texCoord + vec2( 1.0, -1.0) * view, 0.0).rgb);
		
		float lumaDownUp    = lumaDown + lumaUp;
		float lumaLeftRight = lumaLeft + lumaRight;
		
		float lumaLeftCorners  = lumaDownLeft  + lumaUpLeft;
		float lumaDownCorners  = lumaDownLeft  + lumaDownRight;
		float lumaRightCorners = lumaDownRight + lumaUpRight;
		float lumaUpCorners    = lumaUpRight   + lumaUpLeft;
		
		float edgeHorizontal = abs(-2.0 * lumaLeft   + lumaLeftCorners ) +
							   abs(-2.0 * lumaCenter + lumaDownUp      ) * 2.0 +
							   abs(-2.0 * lumaRight  + lumaRightCorners);
		float edgeVertical   = abs(-2.0 * lumaUp     + lumaUpCorners   ) +
							   abs(-2.0 * lumaCenter + lumaLeftRight   ) * 2.0 +
							   abs(-2.0 * lumaDown   + lumaDownCorners );
		
		bool isHorizontal = (edgeHorizontal >= edgeVertical);		
		
		float luma1 = isHorizontal ? lumaDown : lumaLeft;
		float luma2 = isHorizontal ? lumaUp : lumaRight;
		float gradient1 = luma1 - lumaCenter;
		float gradient2 = luma2 - lumaCenter;
		
		bool is1Steepest = abs(gradient1) >= abs(gradient2);
		float gradientScaled = 0.25 * max(abs(gradient1), abs(gradient2));
		
		float stepLength = isHorizontal ? view.y : view.x;

		float lumaLocalAverage = 0.0;

		if (is1Steepest) {
			stepLength = - stepLength;
			lumaLocalAverage = 0.5 * (luma1 + lumaCenter);
		} else {
			lumaLocalAverage = 0.5 * (luma2 + lumaCenter);
		}
		
		vec2 currentUv = texCoord;
		if (isHorizontal) {
			currentUv.y += stepLength * 0.5;
		} else {
			currentUv.x += stepLength * 0.5;
		}
		
		vec2 offset = isHorizontal ? vec2(view.x, 0.0) : vec2(0.0, view.y);
		
		vec2 uv1 = currentUv - offset;
		vec2 uv2 = currentUv + offset;

		float lumaEnd1 = GetLuminance(texture2DLod(colortex1, uv1, 0.0).rgb);
		float lumaEnd2 = GetLuminance(texture2DLod(colortex1, uv2, 0.0).rgb);
		lumaEnd1 -= lumaLocalAverage;
		lumaEnd2 -= lumaLocalAverage;
		
		bool reached1 = abs(lumaEnd1) >= gradientScaled;
		bool reached2 = abs(lumaEnd2) >= gradientScaled;
		bool reachedBoth = reached1 && reached2;
		
		if (!reached1) {
			uv1 -= offset;
		}
		if (!reached2) {
			uv2 += offset;
		}
		
		if (!reachedBoth) {
			for(int i = 2; i < iterations; i++) {
				if (!reached1) {
					lumaEnd1 = GetLuminance(texture2DLod(colortex1, uv1, 0.0).rgb);
					lumaEnd1 = lumaEnd1 - lumaLocalAverage;
				}
				if (!reached2) {
					lumaEnd2 = GetLuminance(texture2DLod(colortex1, uv2, 0.0).rgb);
					lumaEnd2 = lumaEnd2 - lumaLocalAverage;
				}
				
				reached1 = abs(lumaEnd1) >= gradientScaled;
				reached2 = abs(lumaEnd2) >= gradientScaled;
				reachedBoth = reached1 && reached2;

				if (!reached1) {
					uv1 -= offset * quality[i];
				}
				if (!reached2) {
					uv2 += offset * quality[i];
				}
				
				if (reachedBoth) break;
			}
		}
		
		float distance1 = isHorizontal ? (texCoord.x - uv1.x) : (texCoord.y - uv1.y);
		float distance2 = isHorizontal ? (uv2.x - texCoord.x) : (uv2.y - texCoord.y);

		bool isDirection1 = distance1 < distance2;
		float distanceFinal = min(distance1, distance2);

		float edgeThickness = (distance1 + distance2);

		float pixelOffset = - distanceFinal / edgeThickness + 0.5;
		
		bool isLumaCenterSmaller = lumaCenter < lumaLocalAverage;

		bool correctVariation = ((isDirection1 ? lumaEnd1 : lumaEnd2) < 0.0) != isLumaCenterSmaller;

		float finalOffset = correctVariation ? pixelOffset : 0.0;
		
		float lumaAverage = (1.0 / 12.0) * (2.0 * (lumaDownUp + lumaLeftRight) + lumaLeftCorners + lumaRightCorners);
		float subPixelOffset1 = clamp(abs(lumaAverage - lumaCenter) / lumaRange, 0.0, 1.0);
		float subPixelOffset2 = (-2.0 * subPixelOffset1 + 3.0) * subPixelOffset1 * subPixelOffset1;
		float subPixelOffsetFinal = subPixelOffset2 * subPixelOffset2 * subpixelQuality;

		finalOffset = max(finalOffset, subPixelOffsetFinal);
		
		
		// Compute the final UV coordinates.
		vec2 finalUv = texCoord;
		if (isHorizontal) {
			finalUv.y += finalOffset * stepLength;
		} else {
			finalUv.x += finalOffset * stepLength;
		}

		color = texture2DLod(colortex1, finalUv, 0.0).rgb;
	}

	return color;
}

//Program//
void main() {
	vec3 color = texture2DLod(colortex1, texCoord, 0.0).rgb;

	
	color = FXAA311(color);	
	

    /*DRAWBUFFERS:1*/
	gl_FragData[0] = vec4(color, 1.0);
}



//Vertex Shader/////////////////////////////////////////////////////////////////////////////////////







	
	
	

