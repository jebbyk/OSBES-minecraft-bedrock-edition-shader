vec3 colorCorrection(vec3 diffuse){
    vec3 tint = vec3(1.5, 1.25, 1.0)*2.5;
	diffuse.rgb *= tint;

	float contrast = 2.0;
	diffuse.rgb = pow(diffuse.rgb, vec3(contrast));

	// Tone compensation
	diffuse.rgb = diffuse.rgb/(diffuse.rgb + vec3(1.0));
	
	// Gamma correction
	float gamma = 1.0;
	diffuse.rgb = pow(diffuse.rgb, vec3(1.0 / gamma));

	float saturation = 1.0;
	float grayScale = (diffuse.r + diffuse.g + diffuse.b) / 3.0;
	return mix(vec3(grayScale), diffuse.rgb, saturation);
}