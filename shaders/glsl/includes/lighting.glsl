
#include "../uniformShaderConstants"

vec4 calculateSkyLightDiffused(vec3 normalVector, float isRain, float isDay, float isHell){
	vec3 skyLightDirection  = vec3(0.0,1.0,0.0);
	float skyLightWrapping = 8.0;
	float skyDot = max((dot(skyLightDirection, normalVector) + skyLightWrapping)/(1.0 + skyLightWrapping),0.0);
	
	vec3 rainSkyLightColor = vec3(0.6, 0.6, 0.6) * isRain * isDay * 0.5;
	vec3 clearSkyLightColor = pow(FOG_COLOR.rgb, vec3(0.6)) * (1.0 - isRain) * 0.5; 
	
	if(isHell > 0.9){
		clearSkyLightColor = vec3(0.0);
		rainSkyLightColor = vec3(0.0);
	}
	
	return vec4(rainSkyLightColor + clearSkyLightColor, skyDot);
}

vec4 calculateMainLightDiffused(vec3 normalVector, float isDay){
	vec3 sunLightDirection = vec3(0.55,0.4,0.05);
	float globalLightSourceDot = max(dot(sunLightDirection, normalVector), 0.0);	
	vec3 sunLightColor = vec3(1.0, 0.88, 0.69);
	vec3 moonLightColor = vec3(0.35, 0.6,1.0) * 0.35;
	return vec4(mix(moonLightColor, sunLightColor, isDay), globalLightSourceDot);
}

vec3 calculatePointLightsDiffused(float srcPointLights){
	float nearPointLightsBrightness = pow(srcPointLights * 1.15, 32.0);
	float overalPointLightsBrightness = pow(srcPointLights, 2.0) * 0.5 + nearPointLightsBrightness;
	overalPointLightsBrightness *= 2.0;
	overalPointLightsBrightness = clamp(overalPointLightsBrightness, 0.0, 2.0);
	vec3 pointLightsTint = vec3(1.0, 0.66, 0.33);
	vec4 pointLights = vec4(1.0);
	return vec3(overalPointLightsBrightness) * pointLightsTint;
}