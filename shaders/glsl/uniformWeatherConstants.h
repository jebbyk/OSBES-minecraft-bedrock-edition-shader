#ifndef _UNIFORM_WEATHER_CONSTANTS_H
#define _UNIFORM_WEATHER_CONSTANTS_H

#include "uniformMacro.h"

#ifdef MCPE_PLATFORM_NX
uniform WeatherConstants {
#endif
// BEGIN_UNIFORM_BLOCK(WeatherConstants) - Unfortunately this macro does not work on old Amazon platforms, so using above 3 lines instead
UNIFORM vec4 POSITION_OFFSET;
UNIFORM vec4 VELOCITY;
UNIFORM vec4 ALPHA;
UNIFORM vec4 VIEW_POSITION;
UNIFORM vec4 SIZE_SCALE;
UNIFORM vec4 FORWARD;
UNIFORM vec4 UV_INFO;
UNIFORM vec4 PARTICLE_BOX;
END_UNIFORM_BLOCK

#endif
