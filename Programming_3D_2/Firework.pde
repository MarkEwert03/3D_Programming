class Firework {
  PVector loc = new PVector(0, 0, 0);
  PVector vel = new PVector(0, 0, 0);
  int s, alpha;
  float hue;

  Firework(float _x, float _y, float _z, float _vx, float _vy, float _vz, int _s, float _hue) {
    loc.set(_x, _y, _z);
    vel.set(_vx, _vy, _vz); 
    s = _s;
    alpha = 255;
    hue = _hue;
  }//-----------------------------------------------------------------------------------------

  void show() {
    pushMatrix();
    translate(loc.x, loc.y, loc.z);
    if (s == 25) fill(pink);
    else if (s == 4) fill(color(hue, 191, 255), alpha);
    noStroke();
    sphere(s);
    popMatrix();
  }//-----------------------------------------------------------------------------------------

  void act() {
    if (s == 4) alpha-= 2;
    loc.add(vel);
    vel.y += 0.1;
    vel.setMag(5);
  }
}//----------------------------------------------------------------------------------------------------------------------------------------------------------------------
