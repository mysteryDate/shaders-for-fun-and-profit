precision mediump float;

varying vec2 v_uv;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
  vec2 uv = gl_FragCoord.xy/u_resolution.xy;
  gl_FragColor = vec4((v_uv - uv) * 10000.0, 0.0, 1.0);
  // gl_FragColor = vec4(v_uv * u_mouse.xy, 1.0, 1.0);
  // gl_FragColor = vec4(0.5);
  // if (v_uv.x < 1.0)
    // gl_FragColor= vec4(1.0, 0.0, 1.0, 1.0);
}
