#if !defined(TEXEL_AA) || !defined(TEXEL_AA_FEATURE)
#define USE_TEXEL_AA 0
#else
#define USE_TEXEL_AA 1
#endif

#ifdef ALPHA_TEST
#define USE_ALPHA_TEST 1
#else
#define USE_ALPHA_TEST 0
#endif

#if __VERSION__ >= 300

#include "uniformShaderConstants.h"

#if USE_TEXEL_AA

const float TEXEL_AA_LOD_CONSERVATIVE = -1.0;
const float TEXEL_AA_LOD_RELAXED = 2.0;

vec4 texture2D_AA(in sampler2D source, in highp vec2 originalUV) {

	highp vec2 dUV_dX = dFdx(originalUV) * TEXTURE_DIMENSIONS.xy;
	highp vec2 dUV_dY = dFdy(originalUV) * TEXTURE_DIMENSIONS.xy;

	highp vec2 delU = vec2(dUV_dX.x, dUV_dY.x);
	highp vec2 delV = vec2(dUV_dX.y, dUV_dY.y);
	highp vec2 adjustmentScalar = max(1.0 / vec2(length(delU), length(delV)), 1.0);

	highp vec2 fractionalTexel = fract(originalUV * TEXTURE_DIMENSIONS.xy);
	highp vec2 adjustedFractionalTexel = clamp(fractionalTexel * adjustmentScalar, 0.0, 0.5) + clamp(fractionalTexel * adjustmentScalar - (adjustmentScalar - 0.5), 0.0, 0.5);

	highp float lod = log2(sqrt(max(dot(dUV_dX, dUV_dX), dot(dUV_dY, dUV_dY))) * 2.0);
	highp float samplingMode = smoothstep(TEXEL_AA_LOD_RELAXED, TEXEL_AA_LOD_CONSERVATIVE, lod);

	highp vec2 adjustedUV = (adjustedFractionalTexel + floor(originalUV * TEXTURE_DIMENSIONS.xy)) / TEXTURE_DIMENSIONS.xy;
	lowp vec4 blendedSample = texture2D(source, mix(originalUV, adjustedUV, samplingMode));

	#if USE_ALPHA_TEST
		return vec4(blendedSample.rgb, mix(blendedSample.a, smoothstep(1.0/2.0, 1.0, blendedSample.a), samplingMode));
	#else
		return blendedSample;
	#endif
}

#endif //USE_TEXEL_AA

#endif //__VERSION__ >= 300
