#ifndef _UNIFORM_TEXT_CONSTANTS_H
#define _UNIFORM_TEXT_CONSTANTS_H

#include "uniformMacro.h"

#ifdef MCPE_PLATFORM_NX
uniform TextConstants {
#endif
// BEGIN_UNIFORM_BLOCK(TextConstants) - Unfortunately this macro does not work on old Amazon platforms, so using above 3 lines instead
UNIFORM float GLYPH_SMOOTH_RADIUS;
UNIFORM float OUTLINE_CUTOFF;
UNIFORM float SHADOW_SMOOTH_RADIUS;
UNIFORM vec4 SHADOW_COLOR;
UNIFORM vec2 SHADOW_OFFSET;
END_UNIFORM_BLOCK

#endif
