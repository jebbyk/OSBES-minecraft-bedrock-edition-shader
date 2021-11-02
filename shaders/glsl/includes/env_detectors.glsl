#include "../uniformPerFrameConstants.h"
#include "../uniformShaderConstants"

float detectHell(sampler2D texture1){
// Top left pixel is darker in overworld and brighter in the Nether
    float hellDetectionPixel = texture(texture1, vec2(0.0)).r;
   
	return float(hellDetectionPixel > 0.15);
}

float detectDay(sampler2D texture1){
	// Bottom left pixel becomes bluish at night. So we can get exact day time by calulating how much bigger b is than g
	vec3 dayTimeDetectionPixel = texture(texture1, vec2(0.0, 1.0)).rgb;
	float dayTime = dayTimeDetectionPixel.g / dayTimeDetectionPixel.b;
	return pow(dayTime, 5.0);
}

float detectSunRize(){//TODO change detection method and move it to vertex shader
	float isSunrize = dot(normalize(FOG_COLOR.rgb), vec3(1.0, 0.0, 0.0));
	return pow(isSunrize, 4.0);
}

float detectRain(){
	float isRain = 0.5 - FOG_CONTROL.r;
    return clamp(isRain * 5.0, 0.0, 1.0);
}

void detectEnvironment(out float isDay, out float isHell, out float isSunrize, sampler2D texture1){
	isDay = detectDay(texture1);
   	isHell = detectHell(texture1);
	isSunrize = detectSunRize();
}

float detectUnderwater(){
	return float(FOG_CONTROL.r < 0.01);
}