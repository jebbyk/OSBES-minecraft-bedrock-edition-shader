
void calculatePositionDerivatives(out highp vec3 posDerivativesX, out highp vec3 posDerivativesY, in highp vec3 position){
	posDerivativesX = dFdx(position);
	posDerivativesY = dFdy(position);
}

highp vec3 calculateGeometryNormals(highp vec3 position){
    highp vec3 posDerivativesX = dFdx(position);
	highp vec3 posDerivativesY = dFdy(position);

	return normalize(cross(posDerivativesX, posDerivativesY));
}

highp vec3 calculateGeometryNormals(in highp vec3 posDerivativesX, in highp vec3 posDerivativesY){
	return normalize(cross(posDerivativesX, posDerivativesY));
}

highp mat3 buildTBN(highp vec3 posDerivativesX, highp vec3 posDerivativesY, highp vec2 uv, highp vec3 geometryNormal){
	highp vec2 uvDerivativesX = normalize(dFdx(uv));
	highp vec2 uvDerivativesY = normalize(dFdy(uv));

	highp vec3 dp2perp = cross(posDerivativesY, geometryNormal);
	highp vec3 dp1perp = cross(geometryNormal, posDerivativesX);

	highp vec3 T = normalize(dp2perp * uvDerivativesX.x + dp1perp * uvDerivativesY.x);
	highp vec3 B = normalize(dp2perp * uvDerivativesX.y + dp1perp * uvDerivativesY.y);

	highp float invmax = inversesqrt(max(dot(T,T), dot(B,B)));

	return mat3(T *  invmax, B * invmax, geometryNormal);
}

// highp mat3 buildTBN(highp vec3 posDerivativesX, highp vec3 posDerivativesY, highp vec2 uv, highp vec3 geometryNormal){
// 	highp vec3 uv3d = vec3(uv.x, 0.0, uv.y);

// 	highp vec3 uvDerivativesX = normalize(dFdx(uv3d));
// 	highp vec3 uvDerivativesY = normalize(dFdy(uv3d));

// 	highp vec3 T = (uvDerivativesX.x * posDerivativesY - uvDerivativesY.x * posDerivativesX) / (uvDerivativesY.z * uvDerivativesX.x - uvDerivativesY.x * uvDerivativesX.z);
// 	highp vec3 B = (posDerivativesX - uvDerivativesX.z * T) / uvDerivativesX.x;

// 	highp mat3 TBN = transpose(mat3(B, T, geometryNormal));

// 	return TBN;
// }

// mat3 buildTBN(highp vec3 posDerivativesX, highp vec3 posDerivativesY, highp vec2 uv, highp vec3 geometryNormal){
// 	highp vec2 uvDerivativesX = dFdx(uv);
// 	highp vec2 uvDerivativesY = dFdy(uv);

// 	highp vec3 T = normalize(posDerivativesX * uvDerivativesY.y - posDerivativesY * uvDerivativesX.y);
// 	highp vec3 B = normalize(-posDerivativesX * uvDerivativesY.x + posDerivativesY * uvDerivativesX.x);

// 	return highp mat3(T,B,geometryNormal);
// }

float calculateFresnel(vec3 geometryNormal, vec3 normalVector, vec3 viewDir, float isWater, float isRain, float wetness){
    float flatFresnel = min(1.0 - dot(geometryNormal, viewDir), 1.0);
	float detailedFresnel = min(1.0 - dot(normalVector, viewDir), 1.0);

	detailedFresnel = pow(detailedFresnel, 3.0);
	flatFresnel = pow(flatFresnel, 6.0);

	detailedFresnel = mix(detailedFresnel, flatFresnel, flatFresnel * isWater);
	detailedFresnel = mix(detailedFresnel, flatFresnel, wetness * isRain * geometryNormal.g * (1.0 - isWater));
	return clamp(detailedFresnel, 0.0, 1.0);
}