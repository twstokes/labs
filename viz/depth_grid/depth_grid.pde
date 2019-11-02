// inspiration to recreate https://cacheflowe.com/art/digital/deepflat

PImage tex;
PShape cubes;
int x = 0;

void setup() {
  background(0);
  size(1000, 1000, P3D);
  tex = loadImage("grid.png");
  
  ortho();
  noStroke();
  textureWrap(REPEAT);
    
  cubes = generateCubes(1000, 100, PI, PI, 0);
}

void draw() {
  background(0);
  translate(width/2, height/2, 0);
    
  float rotVal = easeInOutSine(x, 0, PI, 1000);
  rotateX(rotVal);
  rotateY(rotVal);
  
  shape(cubes);

  x += 2;
  if (x >= 1000) { x = 0; delay(1500); };
}

// http://www.gizma.com/easing/
float easeInOutSine(float t, float b, float c, float d) {
  return -c/2 * (cos(PI*t/d) - 1) + b;
}

void addVertex(PShape cube, int x, int y, int z) {
  cube.vertex(modelX(x, y, z), modelY(x, y, z), modelZ(x, y, z), screenX(x, y, z), screenY(x, y, z)); 
}

PShape generateCubes(int numCubes, int maxSize, float maxRotX, float maxRotY, float maxRotZ) {
  PShape cubes = createShape(GROUP);
  
  for(int x = 0; x < numCubes; x++) {
    push();
    translate(random(-width/2, width/2), random(-width/2, width/2), random(-width/2, width/2));
    scale(random(0, maxSize));
    rotateX(random(0, maxRotX));
    rotateY(random(0, maxRotY));
    rotateZ(random(0, maxRotZ));
    
    PShape cube = TexturedCube(tex);
    cubes.addChild(cube);
    pop(); 
  }
  
  return cubes;
}

PShape TexturedCube(PImage tex) {
  PShape cube = createShape();
  cube.beginShape(QUADS);
  cube.texture(tex);
  
  // +Z "front" face  
  addVertex(cube, -1, -1, 1);
  addVertex(cube, 1, -1, 1);
  addVertex(cube, 1, 1, 1);
  addVertex(cube, -1, 1, 1);
  
  // -Z "back" face
  addVertex(cube, 1, -1, -1);
  addVertex(cube, -1, -1, -1);
  addVertex(cube, -1, 1, -1);
  addVertex(cube, 1, 1, -1);

  // +Y "bottom" face
  addVertex(cube, -1, 1, 1);
  addVertex(cube, 1, 1, 1);
  addVertex(cube, 1, 1, -1);
  addVertex(cube, -1, 1, -1);

  // -Y "top" face
  addVertex(cube, -1, -1, -1);
  addVertex(cube, 1, -1, -1);
  addVertex(cube, 1, -1, 1);
  addVertex(cube, -1, -1, 1);

  // +X "right" face
  addVertex(cube, 1, -1, 1);
  addVertex(cube, 1, -1, -1);
  addVertex(cube, 1, 1, -1);
  addVertex(cube, 1, 1, 1);

  // -X "left" face
  addVertex(cube, -1, -1, -1);
  addVertex(cube, -1, -1, 1);
  addVertex(cube, -1, 1, 1);
  addVertex(cube, -1, 1, -1);

  cube.endShape();
  
  return cube;
}
