#ifndef _UNIFORM_UI_EFFECTS_PIXEL_CONSTANTS_H
#define _UNIFORM_UI_EFFECTS_PIXEL_CONSTANTS_H

#include "uniformMacro.h"

#ifdef MCPE_PLATFORM_NX
#extension GL_ARB_enhanced_layouts : enable
layout(binding = 3) uniform UIEffectsPixelConstants {
#endif
// BEGIN_UNIFORM_BLOCK(UIEffectsPixelConstants) - Unfortunately this macro does not work on old Amazon platforms, so using above 3 lines instead
UNIFORM vec4 COEFFICIENTS[3];
UNIFORM vec4 PIXEL_OFFSETS[6];
END_UNIFORM_BLOCK

#endif
