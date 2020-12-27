#ifndef _UNIFORM_DEBUG_CONSTANTS_H
#define _UNIFORM_DEBUG_CONSTANTS_H

#include "uniformMacro.h"

#ifdef MCPE_PLATFORM_NX
uniform DebugConstants {
#endif
// BEGIN_UNIFORM_BLOCK(DebugConstants) - Unfortunately this macro does not work on old Amazon platforms, so using above 3 lines instead
UNIFORM float TEXTURE_ARRAY_INDEX_0;
END_UNIFORM_BLOCK

#endif
