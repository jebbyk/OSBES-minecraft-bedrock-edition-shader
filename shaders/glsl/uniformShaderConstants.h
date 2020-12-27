#ifndef _UNIFORM_SHADER_CONSTANTS_H
#define _UNIFORM_SHADER_CONSTANTS_H

#include "uniformMacro.h"

#ifdef MCPE_PLATFORM_NX
#extension GL_ARB_enhanced_layouts : enable
layout(binding = 3) uniform ShaderConstants {
#endif
// BEGIN_UNIFORM_BLOCK(ShaderConstants) - Unfortunately this macro does not work on old Amazon platforms, so using above 3 lines instead
UNIFORM vec4 CURRENT_COLOR;
UNIFORM vec4 DARKEN;
UNIFORM vec3 TEXTURE_DIMENSIONS;
UNIFORM float HUD_OPACITY;
UNIFORM MAT4 UV_TRANSFORM;
END_UNIFORM_BLOCK

#endif
