


float rand(highp vec2 coord){
    return fract(sin(dot(coord.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

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
