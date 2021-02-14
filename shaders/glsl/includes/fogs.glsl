#include "../uniformShaderConstants.h"

vec3 applyBasicFogs(vec3 diffuse, vec3 skyLightDiffused, float fogColor, vec4 milkyFog, float isDay, float isHell){
    diffuse.rgb = mix( diffuse.rgb, skyLightDiffused.rgb, fogColor);
    vec3 milkyFogColor = mix(vec3(0.1), milkyFog.rgb, isDay);
    return mix(diffuse.rgb, milkyFogColor, milkyFog.a * (1.0 - isHell));	
}

vec3 applyBlueFog(vec3 diffuse, vec4 blueFog, float isDay, float isRain, float isWater){
    if(isWater < 0.9 && isRain < 0.9){
        //Add blue fog everywhere when weather is good except water and hell
		return mix(diffuse.rgb, blueFog.rgb, blueFog.a * pow(isDay, 2.0));
	}
    return diffuse;
}

vec3 applyVanillaFog(vec3 diffuse, float fogColorA, float isHell){
    if(isHell > 0.9){ 
        // Default fog in hell because it has no skyplane
		return mix( diffuse.rgb, FOG_COLOR.rgb, fogColor.a);
	}
    return diffuse;
}