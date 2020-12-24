#ifndef _UNIFORM_UI_TRANSFORMS_CONSTANTS_H
#define _UNIFORM_UI_TRANSFORMS_CONSTANTS_H

#include "uniformMacro.h"

#ifdef MCPE_PLATFORM_NX
#extension GL_ARB_enhanced_layouts : enable
layout(binding = 3) uniform UITransformsConstants {
#endif
// BEGIN_UNIFORM_BLOCK(UITransformsConstants) - Unfortunately this macro does not work on old Amazon platforms, so using above 3 lines instead
UNIFORM highp mat4 TRANSFORM;
END_UNIFORM_BLOCK

#endif
