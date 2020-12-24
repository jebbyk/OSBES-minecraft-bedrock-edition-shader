#ifndef _UNIFORM_WORLD_CONSTANTS_H
#define _UNIFORM_WORLD_CONSTANTS_H

#include "uniformMacro.h"

#ifdef MCPE_PLATFORM_NX
layout(binding = 1) uniform WorldConstants {
#endif
//
// BEGIN_UNIFORM_BLOCK(WorldConstants) - Unfortunately this macro does not work on old Amazon platforms, so using above 3 lines instead
UNIFORM MAT4 WORLDVIEWPROJ;
UNIFORM MAT4 WORLD;
UNIFORM MAT4 WORLDVIEW;
UNIFORM MAT4 PROJ;
END_UNIFORM_BLOCK

#endif
