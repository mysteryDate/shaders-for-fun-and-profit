precision mediump float;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float t=5e-3;
void main() {
  // Raymarching loop with a maximum of 64 steps
  for( float i=0.;i<64.;i++) {
    vec3 p=vec3((2.*gl_FragCoord.xy-u_resolution)/u_resolution.yy,t-1.),
         b=vec3(.707,.707,0);
    // Here we a apply a u_time dependent rotation around the Y-axis
    float a=u_time;
    p.xz*=mat2(cos(a),-sin(a),sin(a),cos(a));

    // Fractal iteration loop
    for( float i=0.;i<20.;i++) {
      // Rotating the space again around the Y- and Z-axis,
      // the angle depends on the u_mouse position this u_time
      // and ranges from 0 to (almost) 2π
      a=(u_mouse/u_resolution*600.).x;
      p.xz*=mat2(cos(a),-sin(a),sin(a),cos(a));
      a=(u_mouse/u_resolution*600.).y;
      p.xy*=mat2(cos(a),-sin(a),sin(a),cos(a));

      p-=min(0.,dot(p,b))*b*2.;
      b=b.zxx;
      p-=min(0.,dot(p,b))*b*2.;
      b=b.zxz;
      p-=min(0.,dot(p,b))*b*2.;
      b=b.xxy;
      p=p*1.5-.25;
    }
    t+=length(p)/3325.;
    if(length(p)/3325.<5e-3||t>2.){
      b=vec3(1);
      p*=.5;
      gl_FragColor=vec4(p/length(p)*(t<2.?5./i:i/64.),dot(p,b));
      break;
    }
  }
}