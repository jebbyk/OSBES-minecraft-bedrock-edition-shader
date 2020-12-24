#ifndef _UNIFORM_RENDER_CHUNK_CONSTANTS_H
#define _UNIFORM_RENDER_CHUNK_CONSTANTS_H

#include "uniformMacro.h"

#ifdef MCPE_PLATFORM_NX
#extension GL_ARB_enhanced_layouts : enable
layout(binding = 0) uniform RenderChunkConstants {
#endif
// BEGIN_UNIFORM_BLOCK(RenderChunkConstants) - Unfortunately this macro does not work on old Amazon platforms, so using above 3 lines instead
UNIFORM POS4 CHUNK_ORIGIN_AND_SCALE;
UNIFORM float RENDER_CHUNK_FOG_ALPHA;
END_UNIFORM_BLOCK

#endif
