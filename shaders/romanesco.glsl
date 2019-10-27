precision mediump float;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.14159

float t = 5e-3;
void main() {
  // Raymarching loop with a maximum of 64 steps
  for(float i = 0.0; i < 40.0; i++) {
    vec3 p = vec3((2.0 * gl_FragCoord.xy-u_resolution) / u_resolution.yy, t - 1.0);
    vec3 b = vec3(0.707, 0.707, 0);
    // Here we a apply a time dependent rotation around the Y-axis
    p.xz *= mat2(cos(u_time),-sin(u_time),sin(u_time),cos(u_time));

    // Fractal iteration loop
    for(float i=0.0; i<20.0 ;i++) {
      // Rotating the space again around the Y- and Z-axis,
      // the angle depends on the u_mouse position this u_time
      // and ranges from 0 to (almost) 2π
      vec2 m = (u_mouse * 2.0 * PI);
      p.xz *= mat2(
        cos(m.x), -sin(m.x),
        sin(m.x),  cos(m.x));
      p.xy *= mat2(
        cos(m.y), -sin(m.y),
        sin(m.y),  cos(m.y));

      p -= min(0.0, dot(p, b)) * b * 2.0;
      b = b.zxx;
      p -= min(0.0, dot(p, b)) * b * 2.0;
      b = b.zxz;
      p -= min(0.0, dot(p, b)) * b * 2.0;
      b = b.xxy;
      p = p * 1.5 - 0.25;
    }
    t += length(p) / 3325.0;
    if(length(p)/3325.0<5e-3 || t > 2.0) {
      b = vec3(1);
      p *= 0.5;
      gl_FragColor = vec4(p/length(p) * (t < 2.0 ? 5.0/i : i/64.0), dot(p, b));
      break;
    }
  }
}
