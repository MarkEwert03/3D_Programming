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
  //while (mapY < pokemon.height) {
  //  color pixel = pokemon.get(mapX, mapY);
  //  if (pixel != white) {
  //  worldX = mapX * BS;
  //  worldZ = mapY * BS;
  //  coloredBox(pixel, worldX, worldY, worldZ, BS/2);
  //  }
  //  mapX++;
  //  //1. If you get to the end of the row, move down one pixel
  //  if (pokemon.width-1 < mapX) {
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
  
  pushMatrix();
  translate(map.width*BS/2, 0, map.width*BS/2);
  fill(skyColor);
  stroke(skyColor);
  box(map.width*BS*1.1);
  popMatrix();
}//------------------------------------------------------------------------------------------------------------------

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
