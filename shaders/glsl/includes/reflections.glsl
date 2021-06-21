#include "random.glsl"

vec4 buildRawSkyReflection(vec3 reflectedVector, vec3 resultLighting, float horizonOffset, float horizonScale)
{
	float horizonLine =  1.0 - (abs(reflectedVector.y + horizonOffset) / length(reflectedVector.xyz));
	horizonLine = pow(horizonLine, 16.0 / horizonScale);
	vec3 horizonColor = resultLighting;
	vec3 zenithColor = vec3(0.25, 0.5, 1.0) * length(resultLighting);
	return vec4(mix(zenithColor, horizonColor, horizonLine), horizonLine);
}

vec3 buildSkyPlaneReflection(vec3 reflectedVector, vec4 skyLightReflected, float isRain, float roughness){

	highp vec2 cldCoord = -reflectedVector.xz;
	cldCoord /= abs(reflectedVector.y);
	
	float clouds = cloudsPerlin(CLOUDS_REFLECTIONS_QUALITY, cldCoord / 16.0);

	clouds = pow(clamp(clouds * 1.75, 0.0, 1.0), mix(roughness * 32.0 * abs(reflectedVector.y), 2.0, isRain));
	
	vec3 clearSkyCloudsColor = vec3(1.75) * pow(length(skyLightReflected.gb), 2.0);
	vec3 rainSkyCloudsColor = skyLightReflected.rgb * 0.75;
	
	vec3 cloudsColor = mix(clearSkyCloudsColor, rainSkyCloudsColor, isRain);

	return mix(skyLightReflected.rgb, cloudsColor, clouds * (1.0 - clamp(pow(skyLightReflected.a * 1.0625, 4.0), 0.0, 1.0)));
}


vec4 calculateMainLightsReflection(vec3 normalVector, vec3 viewDir, vec4 mainLightDiffused, float shininess, float isRain, float isSunrize){
	// Blinn-phong
	vec3 fakeLightDir = normalize(vec3(0.9, 0.5, 0.0));
	vec3 halfwayDir = normalize(fakeLightDir + viewDir); 
	float spec = pow(max(dot(normalVector, halfwayDir), 0.0), shininess) * (1.0 - isRain) * 10.0;

#ifdef BETTER_MAIN_LIGHT_REFLECTION
	fakeLightDir = normalize(vec3(0.9, 0.9, 0.0));
	halfwayDir = normalize(fakeLightDir + viewDir); 
	spec += pow(max(dot(normalVector, halfwayDir), 0.0), shininess * 0.0625) * (1.0 - isRain) * 2.0;
#endif

	spec = clamp(spec, 0.0, 10.0);

#ifdef HALO_REFLECTION_ENABLED
	// Phong (fake halo effect)
	float haloPhongIntecity = 2.0 * isSunrize;
	vec3 reflectDir = reflect(-fakeLightDir, normalVector);
	float haloPhong = pow(max(dot(viewDir, reflectDir), 0.0), 8.0) * haloPhongIntecity;

	// The same for onther light source (sunrize, sunset)
	vec3 reversedFakeLightDir = vec3(-0.975, 0.025, 0.0);
	reflectDir = reflect(-reversedFakeLightDir, normalVector);
	float secondHaloPhong = pow(max(dot(viewDir, reflectDir), 0.0), 8.0) * haloPhongIntecity;

	spec += haloPhong + secondHaloPhong;
#endif

	return vec4(mainLightDiffused.rgb, spec * (1.0 - isRain) * mainLightDiffused.a);
}


vec4 calculatePointLightsReflected(vec3 normalVector, vec3 viewDir, float shininess, vec3 pointLightsDiffused)
{
	float spec = pow(max(dot(normalVector, viewDir), 0.0), shininess * 0.25);
	return vec4(pow(min(pointLightsDiffused.rgb * 3.0, 1.0), vec3(2.0)), spec * pointLightsDiffused.r);
}