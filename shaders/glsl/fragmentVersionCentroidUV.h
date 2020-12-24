// To use centroid sampling we need to have version 300 ES shaders, which requires changing:
// - Attribute to in
// - Varying to out when in vertex shaders or in when in fragment shaders
// - Defining an out vec4 FragColor and replacing uses of gl_FragColor with FragColor
// - texture2D to texture
#if __VERSION__ >= 300

#ifdef MSAA_FRAMEBUFFER_ENABLED
#define _centroid centroid
#else
#define _centroid
#endif

// Version 300 code
_centroid in highp vec2 uv;

#define varying in
#define texture2D texture
out vec4 FragColor;
#define gl_FragColor FragColor

#else

// Version 100 code
varying vec2 uv;

#endif
