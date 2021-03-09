#include "../uniformPerFrameConstants"


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
	
	highp float time = TIME;
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

	noise += rand_bilinear((position * scale) + vec2(time * speed)) * intencityMultiplier;
	resultDevider += intencityMultiplier;

	return noise / resultDevider;

}
