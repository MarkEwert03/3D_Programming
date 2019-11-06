//Mark Ewert
//Nov 3

PImage block;
PImage square;
float rotX = PI/4, rotY = PI/4;

void setup() {
  size(800, 600, P3D);
  block  = loadImage("Block.png");
  square = loadImage("Square.png");
  textureMode(NORMAL);
}//----------------------------------------------------------------------------------------------------------------

void draw() {
  background(255);

  noStroke();
  for (int x = -1000; x < 1000; x+= 200){
    for (int z = -2000; z < 0; z+= 200){
      texturedBox(square, x, height, z, 100);
    }
  }
}//----------------------------------------------------------------------------------------------------------------

void texturedBox(PImage _tex, float _x, float _y, float _z, int _scale) { 
  pushMatrix();
  translate(_x, _y, _z);
  scale(_scale);
  rotateX(rotX);
  rotateY(rotY);

  beginShape(QUADS);
  texture(_tex);

  // +Z Front Face
  vertex(-1, -1, 1, 0, 0);  
  vertex( 1, -1, 1, 1, 0);
  vertex( 1, 1, 1, 1, 1);
  vertex(-1, 1, 1, 0, 1);

  // -Z Back Face
  vertex(-1, -1, -1, 1, 0); //Flip X (1 --> 0, and 0 --> 1)
  vertex( 1, -1, -1, 0, 0); //Flip X (1 --> 0, and 0 --> 1)
  vertex( 1, 1, -1, 0, 1); //Flip X (1 --> 0, and 0 --> 1)
  vertex(-1, 1, -1, 1, 1); //Flip X (1 --> 0, and 0 --> 1)

  // +X Right Face
  vertex( 1, -1, 1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, 1, -1, 1, 1);
  vertex( 1, 1, 1, 0, 1);

  // -X Left Face
  vertex(-1, -1, 1, 1, 0); //Flip X (1 --> 0, and 0 --> 1)
  vertex(-1, -1, -1, 0, 0); //Flip X (1 --> 0, and 0 --> 1)
  vertex(-1, 1, -1, 0, 1); //Flip X (1 --> 0, and 0 --> 1)
  vertex(-1, 1, 1, 1, 1); //Flip X (1 --> 0, and 0 --> 1)

  // -Y Top Face
  vertex(-1, -1, -1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, -1, 1, 1, 1);
  vertex(-1, -1, 1, 0, 1);

  // +Y Bottom Face
  vertex(-1, 1, 1, 0, 0);
  vertex( 1, 1, 1, 1, 0);
  vertex( 1, 1, -1, 1, 1);
  vertex(-1, 1, -1, 0, 1);

  endShape();

  popMatrix();
}//----------------------------------------------------------------------------------------------------------------

void mouseDragged() {
  rotX+= (pmouseY - mouseY) * 0.01;
  rotY-= (pmouseX - mouseX) * 0.01;
}//----------------------------------------------------------------------------------------------------------------
