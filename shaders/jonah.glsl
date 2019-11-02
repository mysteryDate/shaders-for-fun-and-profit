#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;

float rand(float i) {
    return i*sin(u_time*123123.123123);
}

float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

float func_x(float x) {
	return x*pow(x, 0.596)/10.0;
}

float func_y(float y) {
    return y*pow(y, 0.632)/10.0;
}

vec2 func(vec2 arg) {
	return vec2(func_x(arg.x), func_y(arg.y));
}

void main() {
    float r = 0.5 + 0.5*sin(u_time/2.23080);
    float g = 0.8 + 0.8*sin(u_time/4.7568);
    float b = 2.5 + 2.5*sin(u_time/1.000);
    // vec2 uv = gl_FragCoord.yx/u_resolution;
    // vec3 color;
    // color.r = uv.x + sin(u_time);
    // color.g = uv.y + sin(2.0*u_time);
    // color.b = u_mouse.x;
    float i = 94040.0*random(gl_FragCoord.xy/u_resolution.xy);
    float modifier = distance(vec2(i, i), gl_FragCoord.xy)/i;
    float rads = cos(u_time*modifier);
    vec4 changer = vec4(1.088,-0.898,1.000,1.184);
    mat2 mat = mat2( 
        changer.x*cos(rads), changer.y*sin(rads),
        changer.z*sin(rads), changer.w*cos(rads)
    );
    // gl_FragColor = vec4(color, 1);
    float width = 25.0*(sin(u_time/1.23123) +2.5);
    vec2 coords = gl_FragCoord.xy/width;
    coords = mat*coords;
    coords = func(coords);
    vec3 color = vec3(0.0, 0.0, 0.0);
    vec2 grids = smoothstep(0.65, 1.0, fract(coords));
    
    grids = mat*grids;
    float val = max(grids.x, grids.y);
    color = vec3(r*val,g*val,b*val*val);
    gl_FragColor = vec4(color, 1.0);
}