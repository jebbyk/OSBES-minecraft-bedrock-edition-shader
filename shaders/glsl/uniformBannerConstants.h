#ifndef _UNIFORM_BANNER_CONSTANTS_H
#define _UNIFORM_BANNER_CONSTANTS_H

#include "uniformMacro.h"

#ifdef MCPE_PLATFORM_NX
uniform BannerConstants {
#endif
// BEGIN_UNIFORM_BLOCK(BannerConstants) - Unfortunately this macro does not work on old Amazon platforms, so using above 3 lines instead
UNIFORM vec4 BANNER_COLORS[7];
UNIFORM vec4 BANNER_UV_OFFSETS_AND_SCALES[7];
END_UNIFORM_BLOCK

#endif
