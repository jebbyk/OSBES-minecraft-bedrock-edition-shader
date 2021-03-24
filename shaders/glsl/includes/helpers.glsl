
highp vec3 calculateRawNormalVector(highp vec3 position){
    highp vec3 dp1 = dFdx(position);
	highp vec3 dp2 = dFdy(position);

	return normalize(cross(dp1, dp2));
}


float calculateFresnel(vec3 initialNormalVector, vec3 normalVector, vec3 viewDir, float isWater, float isRain, float wetness){
    float flatFresnel = min(1.0 - dot(initialNormalVector, viewDir), 1.0);
	float detailedFresnel = min(1.0 - dot(normalVector, viewDir), 1.0);

	detailedFresnel = pow(detailedFresnel, 6.0);
	flatFresnel = pow(flatFresnel, 3.0);

	detailedFresnel = mix(detailedFresnel, flatFresnel, isWater);
	detailedFresnel = mix(detailedFresnel, flatFresnel, wetness * isRain * initialNormalVector.g * (1.0 - isWater));
	return clamp(detailedFresnel, 0.0, 1.0);
}