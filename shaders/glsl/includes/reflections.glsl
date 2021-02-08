#include "../uniformPerFrameConstants"


vec3 buildReflection(vec3 relativePosition, vec3 normalColor, vec4 skyLightReflected, float isRain, float roughness){
	highp float time = TIME;
	highp float cloudsSpeed = 0.1;

	highp vec2 cldCoord = -relativePosition.xz;
	cldCoord += normalColor.rb * 2.0;
	cldCoord /= 1.0 + pow(skyLightReflected.a, 4.0);
	cldCoord /= length(relativePosition.y);
	cldCoord += vec2(time * cloudsSpeed);
	
	float clouds = rand_bilinear(cldCoord);

	clouds = pow(clamp(clouds * 1.5, 0.0, 1.0), mix(roughness * 8.0, 2.0, isRain));
	
	vec3 clearSkyCloudsColor = vec3(1.5) * pow(length(skyLightReflected.gb), 2.0);
	vec3 rainSkyCloudsColor = skyLightReflected.rgb * 0.75;
	
	vec3 cloudsColor = mix(clearSkyCloudsColor, rainSkyCloudsColor, isRain);

	return mix(skyLightReflected.rgb, cloudsColor, clouds);
}
