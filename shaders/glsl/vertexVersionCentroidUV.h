// To use centroid sampling we need to have version 300 ES shaders, which requires changing:
// - Attribute to in
// - Varying to out when in vertex shaders or in when in fragment shaders
// - Defining an out vec4 FragColor and replacing uses of gl_FragColor with FragColor
// - texture2D to texture
#if __VERSION__ >= 300
#define attribute in
#define varying out

#ifdef MSAA_FRAMEBUFFER_ENABLED
#define _centroid centroid
#else
#define _centroid
#endif

_centroid out vec2 uv;

#else

varying vec2 uv;

#endif

