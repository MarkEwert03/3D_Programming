//Mark Ewert
//Nov 3

//Pallete
color darkRed         = #990000;
color red             = #df2020;
color orange          = #df8020;
color yellow          = #dfdf20;
color lime            = #80df20;
color darkGreen       = #269900;
color green           = #50df20;
color mint            = #20df50;
color cyan            = #20dfdf;
color blue            = #2080df;
color navy            = #2020df;
color purple          = #8020df;
color violet          = #df20df;
color pink            = #df2080;
color black           = #000000;
color grey            = #808080;
color white           = #ffffff;
color snowColor       = #c6ddec;
color skyColor        = #cc66ff;
color creeperColor    = #0f800f;

//Textures
PImage block, square;

//Map
PImage map, pokemon;

//Other
final int BS = 20;
float rotX = PI/4, rotY = PI/4;

//Camera
boolean up, down, right, left, space;
float lx = 500, ly = 0 - BS*4, lz = 500;
PVector cameraLoc;
PVector directionX = new PVector(-1, 0);
PVector directionY = new PVector(0, -1);
PVector strafeDirection = new PVector(0, 0);
float headAngleX = 0, headAngleY = 0;

//Bullet
ArrayList<Bullet> bulletList;
int bulletSpawnTimer = 30;

//Firework
ArrayList<Firework> fireworkList;
int fireworkSpwanTimer = 120;

//Snow
ArrayList<Snow> snowList;

//Creeper
ArrayList<Creeper> creeperList;
PImage creeperBody;
PImage creeperHead;
int csTimer = 180;
//--------------------------------------------------------------------------------------------
void setup() {
  size(800, 600, P3D);

  //Map
  map = loadImage("Map.png");

  //Pixel Art Images
  pokemon = loadImage("Snore.png");

  //Textures
  block  = loadImage("Block.png");
  square = loadImage("Square.png");
  textureMode(NORMAL);

  //Bullet
  bulletList = new ArrayList<Bullet>();

  //Firework
  fireworkList = new ArrayList<Firework>();

  //Snow
  snowList = new ArrayList<Snow>();

  //Creeper
  creeperList = new ArrayList<Creeper>();
  creeperBody = loadImage("Creeper Body.png");
  creeperHead = loadImage("Creeper Head.png");

}//----------------------------------------------------------------------------------------------------------------

void draw() {
  background(black);
  noStroke();
  colorMode(HSB);

  camera(lx, directionY.x+ly, lz, directionX.x+lx, directionY.y+ly, directionX.y+lz, 0, 1, 0);
  cameraLoc = new PVector(lx, ly, lz);
  //camera(locX, locY, locZ, dirX, dirY, dirZ, tiltX, tiltY, tiltZ)

  //Moves camera with mouse
  directionX.rotate(headAngleX);
  headAngleX = -(pmouseX - mouseX) * 0.01;
  directionY.rotate(headAngleY);
  headAngleY = (pmouseY - mouseY) * 0.01;

  //Sets speed
  directionX.setMag(BS/4);
  directionY.setMag(BS/8);

  //Stafe direction is for left and right movement
  strafeDirection = directionX.copy();
  strafeDirection.rotate(HALF_PI);

  //Moves with keys
  if (up) {
    lx+= directionX.x;
    lz+= directionX.y;
  }
  if (right) {
    lx += strafeDirection.x;
    lz += strafeDirection.y;
  }
  if (left) {
    lx -= strafeDirection.x;
    lz -= strafeDirection.y;
  }
  if (down) {
    lx-= directionX.x;
    lz-= directionX.y;
  }

  pushMatrix();
  drawMap();
  drawGround();
  popMatrix();

  bulletStuff();
  fireworkStuff();
  snowStuff();
  creeperStuff();
}//----------------------------------------------------------------------------------------------------------------

void keyPressed() {
  if (key == 'w' || keyCode == UP)    up    = true;
  if (key == 'd' || keyCode == RIGHT) right = true;
  if (key == 's' || keyCode == DOWN)  down  = true;
  if (key == 'a' || keyCode == LEFT)  left  = true;
  if (key == ' ') space = true;
}//----------------------------------------------------------------------------------------------------------------

void keyReleased() {
  if (key == 'w' || keyCode == UP)    up    = false;
  if (key == 'd' || keyCode == RIGHT) right = false;
  if (key == 's' || keyCode == DOWN)  down  = false;
  if (key == 'a' || keyCode == LEFT)  left  = false;
  if (key == ' ') space = false;
}//----------------------------------------------------------------------------------------------------------------
