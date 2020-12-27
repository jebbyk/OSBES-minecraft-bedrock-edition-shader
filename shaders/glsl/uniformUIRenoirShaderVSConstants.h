#ifndef _UNIFORM_UI_RENOIR_SHADER_VS_CONSTANTS_H
#define _UNIFORM_UI_RENOIR_SHADER_VS_CONSTANTS_H

#include "uniformMacro.h"

#ifdef MCPE_PLATFORM_NX
#extension GL_ARB_enhanced_layouts : enable
layout(binding = 4) uniform UIRenoirShaderVSConstants {
#endif
// BEGIN_UNIFORM_BLOCK(UIRenoirShaderVSConstants) - Unfortunately this macro does not work on old Amazon platforms, so using above 3 lines instead
UNIFORM highp mat4 COORD_TRANSFORM;
UNIFORM highp vec4 RENOIR_SHADER_VS_PROPS_0;
END_UNIFORM_BLOCK

#endif
