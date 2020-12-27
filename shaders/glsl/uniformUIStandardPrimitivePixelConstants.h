#ifndef _UNIFORM_UI_STANDARD_PRIMITIVE_PIXEL_CONSTANTS_H
#define _UNIFORM_UI_STANDARD_PRIMITIVE_PIXEL_CONSTANTS_H

#include "uniformMacro.h"

#ifdef MCPE_PLATFORM_NX
#extension GL_ARB_enhanced_layouts : enable
layout(binding = 4) uniform UIStandardPrimitivePixelConstants {
#endif
// BEGIN_UNIFORM_BLOCK(UIStandardPrimitivePixelConstants) - Unfortunately this macro does not work on old Amazon platforms, so using above 3 lines instead
UNIFORM int SHADER_TYPE;
END_UNIFORM_BLOCK

#endif
