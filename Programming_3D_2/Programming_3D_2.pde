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

//Textures
PImage block, square;

//Map
PImage map, image;

//Other
final int BS = 20;
float rotX = PI/4, rotY = PI/4;

//Camera
boolean up, down, right, left, space;
float lx = 500, ly = 0 - BS*4, lz = 500;
PVector directionX = new PVector(-1, 0);
PVector directionY = new PVector(0, -1);
PVector strafeDirection = new PVector(0, 0);
float headAngleX = 0, headAngleY = 0;

//Bullet
ArrayList<Bullet> bulletList;
int bulletSpawnTimer = 30;

//Firework
ArrayList<Firework> fireworkList;
int fsTimer = 120;
//--------------------------------------------------------------------------------------------
void setup() {
  size(800, 600, P3D);

  //Map
  map = loadImage("Map.png");

  //Pixel Art Images
  image = loadImage("Snore.png");

  //Textures
  block  = loadImage("Block.png");
  square = loadImage("Square.png");
  textureMode(NORMAL);

  //Bullet
  bulletList = new ArrayList<Bullet>();

  //Firework
  fireworkList = new ArrayList<Firework>();
}//----------------------------------------------------------------------------------------------------------------

void draw() {
  background(255);
  noStroke();
  colorMode(HSB);

  camera(lx, ly, lz, directionX.x+lx, ly+0, directionX.y+lz, 0, 1, 0);
  //camera(locX, locY, locZ, dirX, dirY, dirZ, tiltX, tiltY, tiltZ)

  //Moves camera with mouse
  directionX.rotate(headAngleX);
  headAngleX = -(pmouseX - mouseX) * 0.01;
  directionY.rotate(headAngleY);
  headAngleY = (pmouseY - mouseY) * 0.01;

  //Sets speed
  directionX.setMag(BS/4);
  directionY.setMag(BS/4);

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
}//----------------------------------------------------------------------------------------------------------------

void drawMap() {
  //Texture Box
  int mapX = 0, mapY = 0;
  int worldX = BS, worldY = BS/2, worldZ = BS;
  //0. Looking through all the pixels in the map
  while (mapY < map.height) {
    color pixel = map.get(mapX, mapY);
    //1. If it's a black pixel, put a box there
    if (pixel == black) {
      worldX = mapX * BS;
      worldZ = mapY * BS;
      texturedBox(square, worldX, worldY, worldZ, BS/2);
    }//1.
    mapX++;
    //1. If you get to the end of the row, move down one pixel
    if (mapX > map.width) {
      mapX = 0;
      mapY++;
    }//1.
  }//0.

  ////Color Box
  //int mapX = 0, mapY = 0;
  //int worldX = BS, worldY = BS/2, worldZ = BS;
  ////0. Looking through all the pixels in the map
  //while (mapY < image.height) {
  //  color pixel = image.get(mapX, mapY);
  //  if (pixel != white) {
  //  worldX = mapX * BS;
  //  worldZ = mapY * BS;
  //  coloredBox(pixel, worldX, worldY, worldZ, BS/2);
  //  }
  //  mapX++;
  //  //1. If you get to the end of the row, move down one pixel
  //  if (image.width-1 < mapX) {
  //    mapX = 0;
  //    mapY++;
  //  }//1.
  //}//0.
}//------------------------------------------------------------------------------------------------------------------

void drawGround() {
  strokeWeight(2);
  stroke(0);
  int y = BS;
  for (int x = BS/2; x < map.width*BS; x+= BS) {
    line(x, y, 0, x, y, map.width*BS);
  }
  for (int z = BS/2; z < map.height*BS; z+= BS) {
    line(0, y, z, map.height*BS, y, z);
  }
}//------------------------------------------------------------------------------------------------------------------

void bulletStuff() {
  bulletSpawnTimer--;
  if (space) {
    if (bulletSpawnTimer < 0) {
      bulletList.add( new Bullet(lx, ly, lz, directionX.x, directionX.y));
      bulletSpawnTimer = 30;
    }
  }

  for (int i = 0; i < bulletList.size(); i++) {
    Bullet tempBullet = bulletList.get(i);
    tempBullet.show();
    tempBullet.act();
    if (tempBullet.bulletLifeTimer < 0) bulletList.remove(i);
  }
}//----------------------------------------------------------------------------------------------------------------

void fireworkStuff() {
  fsTimer--;
  if (fsTimer < 0) {
    fireworkList.add(new Firework(random(BS/2, map.width*BS), 0, random(BS/2, map.height*BS), 0, -1, 0, 25, 0));
    fsTimer = 120;
  }

  for (int i = 0; i < fireworkList.size(); i++) {
    Firework tempFirework = fireworkList.get(i);
    tempFirework.show();
    tempFirework.act();
    if (tempFirework.s == 25 && tempFirework.loc.y <=-300) {
      for (int j = 0; j < 100; j++) {
        fireworkList.add(new Firework(tempFirework.loc.x, tempFirework.loc.y, tempFirework.loc.z, random(-1, 1), random(-1, 1), random(-1, 1), 4, random(0, 255)));
      }
      fireworkList.remove(i);
    }
    if (tempFirework.alpha < 0) fireworkList.remove(i);
  }
}//----------------------------------------------------------------------------------------------------------------

void texturedBox(PImage _tex, float _x, float _y, float _z, int _scale) { 
  pushMatrix();
  translate(_x, _y, _z);
  scale(_scale);

  beginShape(QUADS);
  texture(_tex);
  faces();
  endShape();

  popMatrix();
}//----------------------------------------------------------------------------------------------------------------

void coloredBox(color _c, float _x, float _y, float _z, int _scale) { 
  pushMatrix();
  translate(_x, _y, _z);
  scale(_scale);

  beginShape(QUADS);
  fill(_c);
  faces();
  endShape();

  popMatrix();
}//----------------------------------------------------------------------------------------------------------------

void faces() {
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
}//------------------------------------------------------------------------------------------------------------

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
