#define NUMDOTS 14
#define DOTOFFSET 0.04
#define SPEED 0.2
#define POWER 3.0
#define topColor    vec3(0.3, 0.6, 1.0)
#define bottomColor vec3(1.0, 0.4, 0.3)

#define tau 6.283185

precision mediump float;

uniform vec2 u_resolution;
uniform float u_time;

float smoothmin(float a, float b, float k)
{
    float h = clamp(0.5 + 0.5*(b-a)/k, 0.0, 1.0);
    return mix(b, a, h) - k*h*(1.0-h);
}

void main()
{
    vec2 uv = gl_FragCoord.xy/u_resolution.xy - 0.5;
    uv.x *= u_resolution.x/u_resolution.y;

    float d = 9999.0;
    vec3 col;
    for (int i = 0; i < NUMDOTS; i++) {
      float t = pow(
        fract(u_time * SPEED + (float(i) * DOTOFFSET)), POWER);
      vec2 o = vec2(sin(t*tau), cos(t*tau)) * 0.2;
      float dist = length(uv+o) - 0.01;
      if (dist < d)
        col = mix(topColor, bottomColor, cos(t*tau)*0.5 + 0.5);
      d = smoothmin(d, dist, 0.04);
    }
    col = mix(col, vec3(1.0, 1.0, 0.9), smoothstep(0.0, 0.005, d));

    gl_FragColor = vec4(col, 1.0);
}
