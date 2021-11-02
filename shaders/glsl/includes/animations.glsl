#include "../uniformPerFrameConstants.h"
#include "../uniformShaderConstants.h"

#include "includes/options/preset/animations.glsl"

vec2 calculateUnderwaterAnimation(vec3 position) {
          highp float t = TIME;
		
		  highp float wavesMovingSpeed = 0.75;
		  highp float wavesFreq = 2.0;
		  highp float wavesScale = 0.012;

		  float l = length(position.xyz);

		  highp float f0 = sin(t * wavesMovingSpeed + (position.x + position.y + position.z) * wavesFreq ) * wavesScale * l;
		  highp float f1 = cos(t * wavesMovingSpeed + (position.x + position.y + position.z) * wavesFreq ) * wavesScale * l;


		  return vec2(f0, f1);
}

float calculateWaterSurfaceAnimation (vec3 position) {
      highp float t = TIME;
		  highp vec3 rawPosCorrected = position / 2.5463;//2.5463 - chunk scale (detaching prevention)
		
		  highp vec2 wavesMovingSpeed = vec2(3.0, 3.0);
		  highp vec2 wavesFreq = vec2(100.0, 100.0);
		  highp float wavesScale = 0.02;

		  highp vec2 f = sin(t * wavesMovingSpeed + rawPosCorrected.xz * wavesFreq) * wavesScale;

		  return (f.x + f.y)/* (f.x + f.y)*/;
}

float calculateVegetationAnimation (vec3 position, float isRain) {
    vec3 correctedRawPos = position / 2.5463;//2.55 - size of chunk (prevent leaves detaching)
		highp float t = TIME;
		float wavesScale = WIND_WAVES_AMPLITUDE;
		float wavesMovingSpeed = WIND_SPEED * (1.0 + floor(isRain + 0.5) * RAIN_WIND_SPEED_BOOST);

		// Wind impulses
		float impulseDuration = WIND_IMPULSE_CUT / (1.0 + isRain * 2.0);// Bigger number = shorter impulse
		float f = sin(correctedRawPos.x + WIND_IMPULSES_SPEED * t) * 0.5 + 0.5;
		f = clamp(pow(f, impulseDuration), 0.1 + isRain * 0.3, 1.0);
		wavesScale *= f * (1.0 + isRain * RAIN_WIND_AMPLITUDE_BOOST);

		return (1.0 + sin(t * wavesMovingSpeed + (correctedRawPos.x + correctedRawPos.z + correctedRawPos.y) / WIND_WAVES_LENGTH)) * wavesScale;  
}