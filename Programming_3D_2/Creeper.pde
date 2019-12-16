class Creeper {
  PVector loc = new PVector(0, 0, 0);
  int s;

  Creeper(float _x, float _y, float _z, int _s) {
    loc.set(_x, _y, _z);
    s = _s;
  }//-----------------------------------------------------------------------------------------

  void show() {
    noStroke();
    fill(creeperColor);

    texturedBox(creeperHead, loc.x, loc.y-4*s, loc.z, int(s*1.25));
    texturedBox(creeperBody, loc.x, loc.y-2*s, loc.z, s);
    texturedBox(creeperBody, loc.x, loc.y, loc.z, s);
  }//-----------------------------------------------------------------------------------------

  void act() {
    PVector vel = new PVector(lx-loc.x, 0, lz-loc.z);
    vel.setMag(1);
    loc.add(vel);

  }//-----------------------------------------------------------------------------------------
}
