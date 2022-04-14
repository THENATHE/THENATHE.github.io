#version 150 core
#define varying out
#define attribute in
#define gl_Vertex vec4(Position, 1.0)
#define gl_ModelViewProjectionMatrix (gl_ProjectionMatrix * gl_ModelViewMatrix)
#define gl_ModelViewMatrix (iris_ModelViewMat * _iris_internal_translate(iris_ChunkOffset))
#define gl_NormalMatrix mat3(transpose(inverse(gl_ModelViewMatrix)))
#define gl_Normal Normal
#define gl_Color (Color * iris_ColorModulator)
#define gl_MultiTexCoord7  vec4(0.0, 0.0, 0.0, 1.0)
#define gl_MultiTexCoord6  vec4(0.0, 0.0, 0.0, 1.0)
#define gl_MultiTexCoord5  vec4(0.0, 0.0, 0.0, 1.0)
#define gl_MultiTexCoord4  vec4(0.0, 0.0, 0.0, 1.0)
#define gl_MultiTexCoord3  vec4(0.0, 0.0, 0.0, 1.0)
#define gl_MultiTexCoord2  vec4(0.0, 0.0, 0.0, 1.0)
#define gl_MultiTexCoord1 vec4(UV2, 0.0, 1.0)
#define gl_MultiTexCoord0 vec4(UV0, 0.0, 1.0)
#define gl_ProjectionMatrix iris_ProjMat
#define gl_FrontColor iris_FrontColor
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
out float iris_FogFragCoord;
vec4 iris_FrontColor;
uniform mat4 iris_ProjMat;
in vec2 UV0;
in ivec2 UV2;
uniform vec4 iris_ColorModulator;
in vec4 Color;
in vec3 Normal;
uniform mat4 iris_ModelViewMat;
uniform vec3 iris_ChunkOffset;
mat4 _iris_internal_translate(vec3 offset) {
    // NB: Column-major order
    return mat4(1.0, 0.0, 0.0, 0.0,
                0.0, 1.0, 0.0, 0.0,
                0.0, 0.0, 1.0, 0.0,
                offset.x, offset.y, offset.z, 1.0);
}
in vec3 Position;
vec4 ftransform() { return gl_ModelViewProjectionMatrix * gl_Vertex; }
vec4 texture2D(sampler2D sampler, vec2 coord) { return texture(sampler, coord); }
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





















































































	



	
	






























	
	
		
		
	
	










	
	



	
	
	

























    
    
        
        
    
    

















    

    
    
    
    
    
    
    
    
    



    
    
    
    
    
    
    
    
    
    
    
    
    
                    

    





	
						  
						  
    
    
    



	



	
	



















    
    
    
    
    
    
    
    
    



    











	
	
	



    



    

    
    
    
        
                    
    
    

    



    

    
    
    
    
    
    
        
        
        
        
        
    
    

    
    
    
        
            
            
                         
            
            
            
        
        
    
    

    



    
    
               
    
    
    

    
    
    

    
                    

    
    
    

    

    
    
    
    
    
    
    
    
    
        
        
        
        
        
    
    
    
    
    
    

    

    
    
    
    
    

    




                 
                 
    
    
    

    
    
    

    
    
    
    
    
    
    
        
        
        
        
    
    
    
    
    
    
    
    
    

    
    
    

    
    
    
    
    
    

    

    
    
    
    
    
    
    
    

    
    
    
        
    
    
    
    
    
    
    

    
    
    

    
    
    
                        
                        

    
    

    
    
    

    
    
    

    
    

    
    

    
    

    
    

    
    

    
    



    
    
    
    
        

    
    
    

    
    
    
    
    
    
    
                   
    
    
    
    
    
    
    
    
    
    
    



    
    
    



    
    
    
    

	



    
    



    
    
    
    

    
    
    
    

    
    
    
    
    
    
    
    
    
    

    
    

    
    
    

    



                          
    
    
    
    

    

    
    
    
    
    
                        
    
    
    







							
							
							
							
							
							
							
							
						
							   

	
	






    
    



    
    
    
    
    
    
    


    
    
    
    
    
    
    
    
    



    
    
    
    
    
    
    
    
    



    
    
    
    

    
    
    

    
    
    
     
    
    
    
    
    
    

    


    
    

    



    

    
    
        
        
        
    
    
    
    
        
    
        

	


                  
                  
    

    
    
    
    
    

    
    

	
    
    

    
    

    
    
    
    
    
    
    
    
    

    
    

	
    
        
        
        
    
        
        
    
    

    
    
    
    
    

    
    
    
    
    
    
    
    


    
	



    

    
    

    
    

    
    
    

    

    
        
        
        
        
    

    
    

    



                        
    
    

    
    

    
    
    
    

    
                     

    
    

    

    
    
    
        
        
                             
        
        
        
        
    
    
    
    

    




	

    
    
    
    
		  
		  
	



	



    



	
    
    
    
    
	
	
	

    
    
    
    
    
    
    
    

    

	



    
    

	
	
    
    
    
    
    
    
    
    

	
	

    






    
	
	

	
	
	
	
	
	
	
	
		
		
	
	

	
	
	

	
		
		
		
		
		
		
		

		
		
		
		
		
		
		
		
		
		
		
		
		
		

		
		
		
		
					 
		
		
							  
							  

		
			
		
		
		
		
		
		
		

		
		
		
		

    	

		
		
		
			
			
		
		
			
			
		
		
		

		
		
		
		
		
		
		
			
			
			
			
			
		
		
		
		

		
		
		
			  
		
		
		
		

		
		
		
		

		
		
		

		
		
		
		
		
		
		
		
		
		
		
			
											   
		
		

		
		
		
		
		
		
		
		
		
					
					
		
		
		
		
		
			
		
		
		
		
		
		
		
		

		
		
		
		
		

		

		
			
							  
							  

			
			
				
			
		
		

		
		
		
		

		
		
		
			
			
			
			
			
		
		
		
		
		
		
		

		
		
		
		
										   
		
		
		
		
		
			
			
			
		
		

		
		
		
	

    
    

	
	
	
	
	
	




//Vertex Shader/////////////////////////////////////////////////////////////////////////////////////


//Varyings//
varying float mat, recolor;

varying vec2 texCoord, lmCoord;

varying vec3 normal;
varying vec3 sunVec, upVec, eastVec;

varying vec4 color;










//Uniforms//
uniform int worldTime;

uniform float frameTimeCounter;
uniform float timeAngle;

uniform vec3 cameraPosition;

uniform mat4 gbufferModelView, gbufferModelViewInverse;







//Attributes//
attribute vec4 mc_Entity;
attribute vec4 mc_midTexCoord;





//Common Variables//



float frametime = frameTimeCounter * 1.00;


//Includes//
const float pi = 3.1415927;
float pi2wt = 6.2831854 * (frametime * 24.0);

float GetNoise(vec2 pos) {
	return fract(sin(dot(pos, vec2(12.9898, 4.1414))) * 43758.5453);
}

float Noise2D(vec2 pos) {
    vec2 flr = floor(pos);
    vec2 frc = fract(pos);
    frc = frc * frc * (3.0 - 2.0 * frc);

    float n00 = GetNoise(flr);
    float n01 = GetNoise(flr + vec2(0.0, 1.0));
    float n10 = GetNoise(flr + vec2(1.0, 0.0));
    float n11 = GetNoise(flr + vec2(1.0, 1.0));

    float n0 = mix(n00, n01, frc.y);
    float n1 = mix(n10, n11, frc.y);

    return mix(n0, n1, frc.x) - 0.5;
}

vec3 CalcMove(vec3 pos, float density, float speed, vec2 mult) {
    pos = pos * density + frametime * speed;
    vec3 wave = vec3(Noise2D(pos.yz), Noise2D(pos.xz + 0.333), Noise2D(pos.xy + 0.667));
    return wave * vec3(mult, mult.x);
}

float CalcLilypadMove(vec3 worldpos) {
    worldpos.z -= 0.125;
    float wave = sin(2 * pi * (frametime * 0.7 + worldpos.x * 0.14 + worldpos.z * 0.07)) +
                 sin(2 * pi * (frametime * 0.5 + worldpos.x * 0.10 + worldpos.z * 0.20));
    return wave * 0.0125;
}

float CalcLavaMove(vec3 worldpos) {
    float fy = fract(worldpos.y + 0.005);
		
    if (fy > 0.01) {
    float wave = sin(pi * (frametime * 0.7 + worldpos.x * 0.14 + worldpos.z * 0.07)) +
                 sin(pi * (frametime * 0.5 + worldpos.x * 0.10 + worldpos.z * 0.20));
    return wave * 0.0125;
    } else return 0.0;
}

vec3 CalcLanternMove(vec3 position) {
    vec3 frc = fract(position);
    frc = vec3(frc.x - 0.5, fract(frc.y - 0.001) - 1.0, frc.z - 0.5);
    vec3 flr = position - frc;
    float offset = flr.x * 2.4 + flr.y * 2.7 + flr.z * 2.2;

    float rmult = pi * 0.016;
    float rx = sin(frametime       + offset) * rmult;
    float ry = sin(frametime * 1.7 + offset) * rmult;
    float rz = sin(frametime * 1.4 + offset) * rmult;
    mat3 rotx = mat3(
               1,        0,        0,
               0,  cos(rx), -sin(rx),
               0,  sin(rx),  cos(rx)
    );
    mat3 roty = mat3(
         cos(ry),        0,  sin(ry),
               0,        1,        0,
        -sin(ry),        0,  cos(ry)
    );
    mat3 rotz = mat3(
         cos(rz), -sin(rz),        0,
         sin(rz),  cos(rz),        0,
               0,        0,        1
    );
    frc = rotx * roty * rotz * frc;
    
    return flr + frc - position;
}

vec3 WavingBlocks(vec3 position, float istopv) {
    vec3 wave = vec3(0.0);
    vec3 worldpos = position + cameraPosition;

    
    if (mc_Entity.x == 10100 && istopv > 0.9)
        wave += CalcMove(worldpos, 0.35, 1.0, vec2(0.25, 0.06));
    if (mc_Entity.x == 10101 && (istopv > 0.9|| fract(worldpos.y + 0.005) > 0.01))
        wave += CalcMove(worldpos, 0.7, 1.35, vec2(0.12, 0.06));
    if (mc_Entity.x == 10102 && (istopv > 0.9 || fract(worldpos.y + 0.005) > 0.01) ||
        mc_Entity.x == 10103)
        wave += CalcMove(worldpos, 0.35, 1.15, vec2(0.15, 0.06));
    if (mc_Entity.x == 10104 && (istopv > 0.9 || fract(worldpos.y + 0.0675) > 0.01))
        wave += CalcMove(worldpos, 0.35, 1.0, vec2(0.15, 0.06));
    if (mc_Entity.x == 10106)
        wave += CalcMove(worldpos, 0.35, 1.25, vec2(0.06, 0.06));        
    if (mc_Entity.x == 10107 || mc_Entity.x == 10207)
        wave += CalcMove(worldpos, 0.5, 1.25, vec2(0.06, 0.00));
    if (mc_Entity.x == 10108)
        wave.y += CalcLilypadMove(worldpos);
    
    
    if (mc_Entity.x == 10105)
        wave += CalcMove(worldpos, 0.25, 1.0, vec2(0.08, 0.08));
    
    
    if (mc_Entity.x == 10203)
        wave.y += CalcLavaMove(worldpos);
    
    
    if (mc_Entity.x == 10204 && istopv > 0.9)
        wave += CalcMove(worldpos, 1.0, 1.5, vec2(0.0, 0.37));
    if (mc_Entity.x == 10206)
		wave += CalcLanternMove(worldpos);
    

    position += wave;

    return position;
}






							
							
							
							
							
							
							
							
						
							   

	
	





    



//Program//
void main() {
	texCoord = (iris_TextureMat * gl_MultiTexCoord0).xy;
    
	lmCoord = (iris_LightmapTextureMatrix * gl_MultiTexCoord1).xy;
	lmCoord = clamp((lmCoord - 0.03125) * 1.06667, vec2(0.0), vec2(0.9333, 1.0));

	normal = normalize(gl_NormalMatrix * gl_Normal);

	
	
	
	
	
						  
						  
								  
	
	
	

	
	

	
	
	
	
	
    
	color = gl_Color;
	
	mat = 0.0; recolor = 0.0;

	if (mc_Entity.x >= 10100 && mc_Entity.x < 10200)
		mat = 1.0;
	if (mc_Entity.x == 10105 || mc_Entity.x == 10106){
		mat = 2.0;
		color.rgb *= 1.225;
	}
	if (mc_Entity.x >= 10200 && mc_Entity.x < 10300)
		mat = 3.0;
	if (mc_Entity.x == 10203)
		mat = 4.0;
	if (mc_Entity.x == 10208)
		mat = 5.0;

	if (mc_Entity.x == 10201 || mc_Entity.x == 10205 || mc_Entity.x == 10206)
		recolor = 1.0;

	if (mc_Entity.x == 10202)
		lmCoord.x -= 0.0667;

	if (mc_Entity.x == 10203)
		lmCoord.x += 0.0667;

	if (mc_Entity.x == 10400)
		color.a = 1.0;

	const vec2 sunRotationData = vec2(cos(sunPathRotation * 0.01745329251994), -sin(sunPathRotation * 0.01745329251994));
	float ang = fract(timeAngle - 0.25);
	ang = (ang + (cos(ang * 3.14159265358979) * -0.5 + 0.5 - ang) / 3.0) * 6.28318530717959;
	sunVec = normalize((gbufferModelView * vec4(vec3(-sin(ang), cos(ang) * sunRotationData) * 2000.0, 1.0)).xyz);

	upVec = normalize(gbufferModelView[1].xyz);
	eastVec = normalize(gbufferModelView[0].xyz);

	vec4 position = gbufferModelViewInverse * gl_ModelViewMatrix * gl_Vertex;
	
	float istopv = gl_MultiTexCoord0.t < mc_midTexCoord.t ? 1.0 : 0.0;
	position.xyz = WavingBlocks(position.xyz, istopv);

    
	
    

	gl_Position = gl_ProjectionMatrix * gbufferModelView * position;
	
	
	
	
}




