#include "../uniformPerFrameConstants"


vec3 buildSkyPlaneReflection(vec3 relativePosition, vec3 normalColor, vec4 skyLightReflected, float isRain, float roughness){
	highp float time = TIME;
	highp float cloudsSpeed = 0.1;

	highp vec2 cldCoord = -relativePosition.xz;
	cldCoord += cldCoord * normalColor.rb * 0.5;
	cldCoord /= length(relativePosition.y);
	cldCoord += vec2(time * cloudsSpeed);
	
	float clouds = rand_bilinear(cldCoord);

	clouds = pow(clamp(clouds * 1.5, 0.0, 1.0), mix(roughness * 8.0, 2.0, isRain));
	
	vec3 clearSkyCloudsColor = vec3(1.5) * pow(length(skyLightReflected.gb), 2.0);
	vec3 rainSkyCloudsColor = skyLightReflected.rgb * 0.75;
	
	vec3 cloudsColor = mix(clearSkyCloudsColor, rainSkyCloudsColor, isRain);

	return mix(skyLightReflected.rgb, cloudsColor, clouds);
}


vec4 calculateMainLightsReflection(vec3 normalVector, vec3 viewDir, vec4 mainLightDiffused, float shininess, float isRain, float isSunrize){
	// Blinn-phong
	highp vec3 fakeLightDir = vec3(0.975, 0.025, 0.0);
	highp vec3 halfwayDir = normalize(fakeLightDir + viewDir); 
	highp float spec = pow(max(dot(normalVector, halfwayDir), 0.0), shininess) * (1.0 - isRain) * 10.0;

	// Phong (fake halo effect)
	float haloPhongIntecity = 2.0 * isSunrize;
	vec3 reflectDir = reflect(-fakeLightDir, normalVector);
	float haloPhong = pow(max(dot(viewDir, reflectDir), 0.0), 8.0) * haloPhongIntecity;

	// The same for onther light source (sunrize, sunset)
	highp vec3 reversedFakeLightDir = vec3(-0.975, 0.025, 0.0);
	reflectDir = reflect(-reversedFakeLightDir, normalVector);
	float secondHaloPhong = pow(max(dot(viewDir, reflectDir), 0.0), 8.0) * haloPhongIntecity;

	spec += haloPhong + secondHaloPhong;

	return vec4(mainLightDiffused.rgb, spec * (1.0 - isRain) * mainLightDiffused.a);
}


vec4 calculatePointLightsReflected(vec3 normalVector, vec3 viewDir, float shininess, vec3 pointLightsDiffused)
{
	float spec = pow(max(dot(normalVector, viewDir), 0.0), shininess * 0.25);
	return vec4(pow(min(pointLightsDiffused.rgb * 3.0, 1.0), vec3(2.0)), spec * pointLightsDiffused.r);
}