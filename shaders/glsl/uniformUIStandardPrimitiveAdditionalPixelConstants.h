#ifndef _UNIFORM_UI_STANDARD_PRIMITIVE_ADDITIONAL_PIXEL_CONSTANTS_H
#define _UNIFORM_UI_STANDARD_PRIMITIVE_ADDITIONAL_PIXEL_CONSTANTS_H

#include "uniformMacro.h"

#ifdef MCPE_PLATFORM_NX
#extension GL_ARB_enhanced_layouts : enable
layout(binding = 3) uniform UIStandardPrimitiveAdditionalPixelConstants {
#endif
// BEGIN_UNIFORM_BLOCK(UIStandardPrimitiveAdditionalPixelConstants) - Unfortunately this macro does not work on old Amazon platforms, so using above 3 lines instead
UNIFORM vec4 PRIM_PROPS_0;
UNIFORM vec4 PRIM_PROPS_1;
END_UNIFORM_BLOCK

#endif
