#ifndef _UNIFORM_INTER_FRAME_CONSTANTS_H
#define _UNIFORM_INTER_FRAME_CONSTANTS_H

#include "uniformMacro.h"

#ifdef MCPE_PLATFORM_NX
uniform InterFrameConstants {
#endif
// BEGIN_UNIFORM_BLOCK(InterFrameConstants) - Unfortunately this macro does not work on old Amazon platforms, so using above 3 lines instead
// in secs. This is reset every 1 hour. so the range is [0, 3600]
// Make sure your shader handles the case when it transitions from 3600 to 0
UNIFORM float TOTAL_REAL_WORLD_TIME;
UNIFORM MAT4 CUBE_MAP_ROTATION;
END_UNIFORM_BLOCK

#endif
