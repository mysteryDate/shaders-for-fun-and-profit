let gl, glProgram;

function init(shadercode) {
  const vertexShader = gl.createShader(gl.VERTEX_SHADER);
  gl.shaderSource(vertexShader, `
    attribute vec2 pos;
    void main() {
      gl_Position = vec4(pos, 0, 1);
    }`);
  gl.compileShader(vertexShader);
  gl.attachShader(glProgram, vertexShader);

  const fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);
  gl.shaderSource(fragmentShader, shadercode);
  gl.compileShader(fragmentShader);
  if (!gl.getShaderParameter(fragmentShader, gl.COMPILE_STATUS)) {
    console.error(gl.getShaderInfoLog(fragmentShader));
  }

  gl.attachShader(glProgram, fragmentShader);
  gl.linkProgram(glProgram);
  if (!gl.getProgramParameter(glProgram, gl.LINK_STATUS)) {
    console.error(gl.getProgramInfoLog(glProgram));
  }

  gl.useProgram(glProgram);

  const bf = gl.createBuffer();
  gl.bindBuffer(gl.ARRAY_BUFFER, bf);
  gl.bufferData(gl.ARRAY_BUFFER, new Int8Array([-3, 1, 1, -3, 1, 1]), gl.STATIC_DRAW);

  gl.enableVertexAttribArray(0);
  gl.vertexAttribPointer(0, 2, gl.BYTE, 0, 0, 0);

  gl.uniform2f(gl.getUniformLocation(glProgram, "u_resolution"), canvas.width, canvas.height);
  gl.uniform2f(gl.getUniformLocation(glProgram, "u_mouse"), 0, 0);
  gl.drawArrays(6, 0, 3);
}

function update() {
  gl.uniform1f(gl.getUniformLocation(glProgram, "u_time"), performance.now() / 1000);
  gl.drawArrays(6, 0, 3);
  requestAnimationFrame(update);
}

function createShaderCanvas(canvas, path) {
  gl = canvas.getContext("webgl");
  glProgram = gl.createProgram();

  canvas.onmousemove = function(e) {
    const x = e.clientX / canvas.clientWidth;
    const y = 1.0 - e.clientY / canvas.clientHeight;
    gl.uniform2f(gl.getUniformLocation(glProgram, "u_mouse"), x, y);
  }

  fetch(path).then(response => response.text())
    .then((data) => {
      init(data);
      update();
    });
};
