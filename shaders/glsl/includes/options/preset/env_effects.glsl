#include "../uniformPerFrameConstants.h"
#include "../uniformShaderConstants.h"
//#include "env_detectors.glsl" // for some reason including from here doesnt work
//#include "options/preset/animations.glsl" // and values are also not work

POS4 transformEffects( POS4 pos, bool isUW) {
    if (isUW) {
      return vec4(pos.xy + sin(pos.x + pos.y + pos.z + (TIME * 1.0)) * 0.05, pos.zw);
    }else{
      return pos;
    }
}