class Bullet {
  PVector loc = new PVector(0, 0, 0);
  PVector vel = new PVector(0, 0, 0);
  int bulletLifeTimer;
  
  Bullet(float _x, float _y, float _z, float _vx, float _vz) {
    loc.set(_x, _y, _z);
    vel.set(_vx, 0, _vz);
    bulletLifeTimer = 120;
  }//-----------------------------------------------------------------------------------------

  void show() {
    pushMatrix();
    translate(loc.x, loc.y, loc.z);
    fill(blue);
    stroke(navy);
    strokeWeight(2);
    box(5);
    bulletLifeTimer--;
    popMatrix();
  }//-----------------------------------------------------------------------------------------

  void act() {
    loc.add(vel);
    vel.setMag(20);
    
  }//-----------------------------------------------------------------------------------------
}
