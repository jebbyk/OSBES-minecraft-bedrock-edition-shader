#ifndef _UNIFORM_FLIPBOOK_TEXTURE_CONSTANTS_H
#define _UNIFORM_FLIPBOOK_TEXTURE_CONSTANTS_H

#include "uniformMacro.h"

#ifdef MCPE_PLATFORM_NX
uniform FlipbookTextureConstants {
#endif
// BEGIN_UNIFORM_BLOCK(FlipbookTextureConstants) - Unfortunately this macro does not work on old Amazon platforms, so using above 3 lines instead
UNIFORM float V_OFFSET;
UNIFORM float V_BLEND_OFFSET;
END_UNIFORM_BLOCK

#endif
