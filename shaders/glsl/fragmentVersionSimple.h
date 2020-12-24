// To use centroid sampling we need to have version 300 ES shaders, which requires changing:
// attribute to in
// varying to out when in vertex shaders or in when in fragment shaders
// defining an out vec4 FragColor and replacing uses of gl_FragColor with FragColor
// texture2D to texture
#if __VERSION__ >= 300

// version 300 code

#define varying in
#define texture2D texture
out vec4 FragColor;
#define gl_FragColor FragColor

#else

// version 100 code

#endif
