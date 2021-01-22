

float detectHell(sampler2D texture1){
// Top left pixel is darker in overworld and brighter in the Nether
    float hellDetectionPixel = texture2D(texture1, vec2(0.0)).r;
   
	if (hellDetectionPixel > 0.15){
		return 1.0;
	}
    return 0.0;
}