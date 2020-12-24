// To use centroid sampling we need to have version 300 ES shaders, which requires changing:
// - Attribute to in
// - Varying to out when in vertex shaders or in when in fragment shaders
// - Defining an out vec4 FragColor and replacing uses of gl_FragColor with FragColor
// - texture2D to texture

#if __VERSION__ >= 300
#define attribute in
#define varying out

#else


#endif

