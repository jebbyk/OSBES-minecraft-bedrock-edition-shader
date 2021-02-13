
highp vec3 calculateRawNormalVector(highp vec3 position){
    highp vec3 dp1 = dFdx(position);
	highp vec3 dp2 = dFdy(position);

	return normalize(cross(dp1, dp2));
}