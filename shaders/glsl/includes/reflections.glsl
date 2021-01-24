#include "../uniformPerFrameConstants"


vec3 buildReflection(vec3 relativePosition, vec3 normalColor, vec4 skyLightReflected, float isRain, float specularMap){
	highp float time = TIME;
	highp float cloudsSpeed = 0.1;

	highp vec2 cldCoord = -relativePosition.xz;
	cldCoord += normalColor.rb * 2.0;
	cldCoord /= 1.0 + pow(skyLightReflected.a, 4.0);
	cldCoord /= length(relativePosition.y);
	cldCoord += vec2(time * cloudsSpeed);
	
	float clouds = rand_bilinear(cldCoord);

	clouds = pow(clamp(clouds * 1.75, 0.0, 1.0), mix(specularMap * 128.0, 2.0, isRain));
	
	vec3 clearSkyCloudsColor = vec3(0.6, 0.75, 0.9) * pow(FOG_COLOR.b, 2.0) * 1.5;
	vec3 rainSkyCloudsColor = vec3(0.6, 0.75, 0.9) * pow(FOG_COLOR.b, 2.0) * 2.0;
	
	vec3 cloudsColor = mix(clearSkyCloudsColor, rainSkyCloudsColor, isRain);

	return mix(pow(skyLightReflected.rgb,vec3(2.0)), cloudsColor, clouds);
}