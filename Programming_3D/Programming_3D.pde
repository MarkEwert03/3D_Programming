//Mark Ewert
//Oct  29

//Colours
color red             = #df2020;
color orange          = #df8020;
color yellow          = #dfdf20;
color lime            = #80df20;
color green           = #50df20;
color mint            = #20df50;
color cyan            = #20dfdf;
color blue            = #2080df;
color navy            = #2020df;
color purple          = #8020df;
color violet          = #df20df;
color pink            = #df2080;
color black           = 0;
color grey            = 127;
color white           = 255;

PImage sudo;

void setup() {
  size(800, 600, P3D);

  imageMode(CENTER);
  sudo = loadImage("Sudowoodo.png");
}

void draw() {
  //Basic
  background(175);
  sudo.resize(414, 480);
  imageMode(CENTER);

  float angleX = map(mouseX, 0, width/2, 0, TWO_PI);
  float angleY = map(mouseY, 0, height/2, 0, TWO_PI);

  pushMatrix(); //Push---
  translate(width/2, height/2);
  rotateX(angleY);
  rotateY(angleX);
  grid();
  //image(sudo, 0, 0);
  popMatrix(); //Pop---
}


void grid() {
  stroke(0);
  strokeWeight(1);
  for (int x = -width; x<width; x+=20) {
    line(x, -height, x, height);
  }

  for (int y = -height; y<height; y+=20) {
    line(-width, y, width, y);
  }
}
