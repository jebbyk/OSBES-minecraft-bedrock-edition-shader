#ifndef _UNIFORM_UI_GLOBAL_PIXEL_CONSTANTS_H
#define _UNIFORM_UI_GLOBAL_PIXEL_CONSTANTS_H

#include "uniformMacro.h"

#ifdef MCPE_PLATFORM_NX
#extension GL_ARB_enhanced_layouts : enable
layout(binding = 4) uniform UIGlobalPixelConstants {
#endif
// BEGIN_UNIFORM_BLOCK(UIGlobalPixelConstants) - Unfortunately this macro does not work on old Amazon platforms, so using above 3 lines instead
UNIFORM vec2 VIEWPORT_SIZE;
END_UNIFORM_BLOCK

#endif
