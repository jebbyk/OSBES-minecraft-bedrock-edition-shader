vec3 colorCorrection(vec3 diffuse){

	diffuse.rgb *= TONE_MAPPING_TINT * TONE_MAPPING_BRIGHTNESS;

	diffuse.rgb = pow(diffuse.rgb, vec3(TONE_MAPPING_CONTRAST));

	// Tone compensation
	diffuse.rgb = diffuse.rgb / (diffuse.rgb + vec3(1.0));
	
	// Gamma correction
	diffuse.rgb = pow(diffuse.rgb, vec3(1.0 / TONE_MAPPING_GAMMA));

	float grayScale = (diffuse.r + diffuse.g + diffuse.b) / 3.0;
	return mix(vec3(grayScale), diffuse.rgb, TONE_MAPPING_SATURATION);
}