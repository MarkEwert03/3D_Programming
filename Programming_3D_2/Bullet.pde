class Bullet {
  PVector location = new PVector(0, 0, 0);
  PVector velocity = new PVector(0, 0, 0);
  int bulletLifeTimer;
  
  Bullet(float _x, float _y, float _z, float _vx, float _vz) {
    location.set(_x, _y, _z);
    velocity.set(_vx, 0, _vz);
    bulletLifeTimer = 120;
  }//-----------------------------------------------------------------------------------------

  void show() {
    pushMatrix();
    translate(location.x, location.y, location.z);
    fill(blue);
    stroke(navy);
    strokeWeight(2);
    box(5);
    bulletLifeTimer--;
    popMatrix();
  }//-----------------------------------------------------------------------------------------

  void act() {
    location.add(velocity);
    velocity.setMag(20);
    
  }//-----------------------------------------------------------------------------------------
}
