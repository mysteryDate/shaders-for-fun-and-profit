precision mediump float;

varying vec2 v_uv;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform sampler2D u_mainTex;

void main() {
  vec2 uv = gl_FragCoord.xy / u_resolution;
  vec3 tex = texture2D(u_mainTex, uv).rgb;
  gl_FragColor = vec4(tex, 1.0);
}
