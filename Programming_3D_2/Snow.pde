class Snow {
  PVector loc = new PVector(0, 0, 0);
  PVector vel = new PVector(0, 0, 0);
  float s;
  int alpha;

  Snow(float _x, float _y, float _z, float _vx, float _vy, float _vz, int _s) {
    loc.set(_x, _y, _z);
    vel.set(_vx, _vy, _vz);
    s = _s;
  }//-----------------------------------------------------------------------------------------

  void show() {
    pushMatrix();
    translate(loc.x, loc.y, loc.z);
    noStroke();
    fill(snowColor);
    sphere(s);
    popMatrix();
  }//-----------------------------------------------------------------------------------------

  void act() {
    loc.add(vel);
    vel.setMag(5);
  }//-----------------------------------------------------------------------------------------
}
