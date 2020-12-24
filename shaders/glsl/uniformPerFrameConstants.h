#ifndef _UNIFORM_PER_FRAME_CONSTANTS_H
#define _UNIFORM_PER_FRAME_CONSTANTS_H

#include "uniformMacro.h"

#ifdef MCPE_PLATFORM_NX
layout(binding = 2) uniform PerFrameConstants {
#endif
// BEGIN_UNIFORM_BLOCK(PerFrameConstants) - Unfortunately this macro does not work on old Amazon platforms, so using above 3 lines instead
UNIFORM vec3 VIEW_POS;
UNIFORM highp float TIME;
UNIFORM vec4 FOG_COLOR;
UNIFORM vec2 FOG_CONTROL;
UNIFORM float RENDER_DISTANCE;
UNIFORM float FAR_CHUNKS_DISTANCE;
END_UNIFORM_BLOCK

#endif
