#include "../uniformPerFrameConstants"




float detectHell(sampler2D texture1){
// Top left pixel is darker in overworld and brighter in the Nether
	float hellDetectionPixel = texture2D(texture1, vec2(0.0)).r;

	if (hellDetectionPixel > 0.15){
		return 1.0;
	}
	return 0.0;
}

float detectDay(sampler2D texture1){
	// Bottom left pixel becomes bluish at night. So we can get exact day time by calulating how much bigger b is than g
	vec3 dayTimeDetectionPixel = texture2D(texture1, vec2(0.0, 1.0)).rgb;
	float dayTime = dayTimeDetectionPixel.g / dayTimeDetectionPixel.b;
	return pow(dayTime, 5.0);
}

float detectSunRize(){//TODO change detection method and move it to vertex shader
	float isSunrize = dot(normalize(FOG_COLOR.rgb), vec3(1.0, 0.0, 0.0));
	return pow(isSunrize, 4.0);
}






vec3 toLinear(vec3 color){
	return pow(color, vec3(gamma));
}

vec3 toGamma(vec3 color){
	return pow(color, vec3(1.0/gamma));
}

vec3 tonemapFilmic(vec3 ccolor) {
	vec3 x = max(vec3(0.0, 0.0, 0.0), ccolor - 0.004);
	return (x * (6.2 * x + 0.5)) / (x * (6.2 * x + 1.7) + 0.06);
}

vec3 tonemapReinhard(vec3 ccolor) {
	return ccolor / (ccolor + vec3(1.0, 1.0, 1.0));
}

float luminance(vec3 color){
	return dot(color, vec3(0.2125, 0.7154, 0.0721));
}

vec3 colorCorrection(vec3 color){
	vec3 tint = vec3(1.4, 1.25, 1.1) * exposureMult;
	color.rgb *= tint;

	// Tone compensation with similar range tonemapFilmic so dont need gamma conversion
	color.rgb = color.rgb / (0.98135426889 * color + 0.98135426889 * 0.154);

	// Gamma correction
	//color.rgb = toGamma(color);

	float grayScale = (color.r + color.g + color.b) / 3.0;
	return mix(vec3(grayScale), color.rgb, saturation);
}









float rand(highp vec2 coord){
	return fract(sin(dot(coord.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

//float rand(vec2 xy){
//       return fract(tan(distance(xy*1.61803398874989484820459, xy)*1.0)*xy.x);
//}

float step_random(highp vec2 coord){
	vec2 flooredCoord = floor(coord);
	return rand(flooredCoord);
}

float rand_bilinear(highp vec2 coord){

	vec2 flooredCoord = floor(coord);

	float leftTopSample = rand(flooredCoord);
	float righTopSample = rand(flooredCoord + vec2(0.0, 1.0));
	float leftBottomSample = rand(flooredCoord + vec2(1.0, 0.0));
	float rightBottomSample = rand(flooredCoord + vec2(1.0, 1.0));

	vec2 fractionalPart = coord - flooredCoord;

	float topRow = mix(leftTopSample, righTopSample, fractionalPart.y);
	float botRow = mix(leftBottomSample, rightBottomSample, fractionalPart.y);

	float result = mix(topRow, botRow, fractionalPart.x);

	return result;
}

float cloudsPerlin(int octaves, vec2 position){

	position = clamp(position, -1.0, 1.0);

	float speed = 0.1;
	float scale = 16.0;
	float scaleMultiplier = pow(2.0, float(octaves)); //  smaller scale - bigger noise
	float intencityMultiplier = 1.0;
	float resultDevider = 0.0;

	float noise = 0.0;

	while(scaleMultiplier > 1.5){
		noise += rand_bilinear(position * scale * scaleMultiplier) * intencityMultiplier;
		resultDevider += intencityMultiplier;
		scaleMultiplier /= 2.0;
		intencityMultiplier *= 2.0;
	}

	noise += rand_bilinear((position * scale) + vec2(TOTAL_REAL_WORLD_TIME * speed)) * intencityMultiplier;
	resultDevider += intencityMultiplier;

	return noise / resultDevider;

}







vec3 fresnelSchlick(vec3 f0, float dotproduct){ return f0 + (1.0 - f0) * pow(1.0 - dotproduct, 5.0); }

float ditributionBlinn(float roughness, float normalDotHalf){
	float m = roughness * roughness;
	float m2 = m * m;
	float n = 2.0 / m2 - 2.0;

	return (n + 2.0) / (2.0 * pi) * pow(normalDotHalf, n);
}

float ditributionBeckmann(float roughness, float normalDotHalf){
	float m = roughness * roughness;
	float m2 = m * m;

	float normalDotHalfSquared = normalDotHalf * normalDotHalf;
	return exp((normalDotHalfSquared - 1.0) / (m2 * normalDotHalfSquared)) / (pi * m2 * normalDotHalfSquared * normalDotHalfSquared);
}

float ditributionGGX(float roughness, float normalDotHalf){
	float m = roughness * roughness;
	float m2 = m * m;

	float d = (normalDotHalf * m2 - normalDotHalf) * normalDotHalf + 1.0;
	return m2 / (pi * d * d);
}

float geometrySchlick(float roughness, float normalDotView, float normalDotLight){
	float k = roughness * roughness * 0.5;

	float V = normalDotView * (1.0 - k) + k;

	float L = normalDotLight * (1.0 - k) + k;
	return 0.25 / (V * L);
}

vec3 cookTorranceSpecular(float normalDotLight, float normalDotView, float normalDotHalf, vec3 fresnel, float roughness){

	float normalDistribution = ditributionGGX(roughness, normalDotHalf);

	float geometryLight = geometrySchlick(roughness, normalDotView, normalDotLight);
	float rim = mix(1.0 - roughness * 0.9, 1.0, normalDotView);
	return (1.0 / rim) * fresnel * geometryLight * normalDistribution;
}


vec3 phongSpecular(vec3 viewDirection, vec3 lightPos, vec3 normal, vec3 fresnel, float roughness){
	vec3 reflectedLight = reflect(-lightPos, normal);
	float spec = max(0.0, dot(viewDirection, reflectedLight));

	float k = 1.999 / (roughness * roughness);

	return min(1.0, 3.0 * 0.0398 * k) * pow(spec, min(10000.0, k)) * fresnel;
}


vec3 blinnSpecular(float normalDotHalf, vec3 fresnel, float roughness){
	float k = 1.999 / (roughness * roughness);

	return min(1.0, 3.0 * 0.0398 * k) * pow(normalDotHalf, min(10000.0, k)) * fresnel;
}

vec3 getTangentVector(vec3 normal){
	vec3 attangent;

	if(normal.x > 0.5) attangent = vec3(0.0,0.0,-1.); else if(normal.x < -0.5) attangent = vec3(0.0,0.0,1.0); else if(normal.y > 0.5) attangent = vec3(1.0,0.0,0.0); else if(normal.y < -0.5) attangent = vec3(1.0,0.0,0.0); else if(normal.z > 0.5) attangent = vec3(1.0,0.0,0.0); else if(normal.z < -0.5) attangent = vec3(-1.0,0.0,0.0);

	return attangent;
}
