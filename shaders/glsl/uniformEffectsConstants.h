#ifndef _UNIFORM_EFFECTS_CONSTANTS_H
#define _UNIFORM_EFFECTS_CONSTANTS_H

#include "uniformMacro.h"

#ifdef MCPE_PLATFORM_NX
uniform EffectsConstants {
#endif
// BEGIN_UNIFORM_BLOCK(EffectsConstants) - Unfortunately this macro does not work on old Amazon platforms, so using above 3 lines instead
UNIFORM vec2 EFFECT_UV_OFFSET;
END_UNIFORM_BLOCK

#endif
