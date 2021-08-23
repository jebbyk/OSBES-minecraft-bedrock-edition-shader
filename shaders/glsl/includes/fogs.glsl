#include "../uniformShaderConstants.h"

vec3 applyBasicFogs(vec3 diffuse, vec3 skyLightDiffused, float fogIntancity, vec4 milkyFog, float isDay, float isHell){
    diffuse = mix( diffuse, skyLightDiffused, fogIntancity);
    #ifdef HORIZONTAL_FOG_ENABLED 
        vec3 milkyFogColor = mix(vec3(0.01), milkyFog.rgb, isDay);
        return mix(diffuse.rgb, milkyFogColor, milkyFog.a * (1.0 - isHell));
    #else
        return diffuse;
    #endif
}

vec3 applyDistanceFog(vec3 diffuse, vec4 distanceFog, float isDay, float isRain, float isWater){
    if(isWater < 0.9 && isRain < 0.9){
        //Add distance fog everywhere when weather is good except water and hell
		return mix(diffuse.rgb, distanceFog.rgb, distanceFog.a * pow(isDay, 2.0));
	}
    return diffuse;
}

vec3 applyVanillaFog(vec3 diffuse, float fogColorA, float isHell, float isUnderWater){
    if(isHell > 0.9){ 
        // Default fog in hell because it has no skyplane
        if(isUnderWater > 0.9){
            return mix( diffuse.rgb, FOG_COLOR.rgb, clamp(fogColor.a + UNDERWATER_FOG_MIN, 0.0, 1.0));
        }else{
            return mix( diffuse.rgb, FOG_COLOR.rgb, fogColor.a);
        }
		
	}
    return diffuse;
}