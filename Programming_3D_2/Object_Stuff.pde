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
    if (tempBullet.bulletLifeTimer < 0) {
      bulletList.remove(i);
    }
  }
}//----------------------------------------------------------------------------------------------------------------

void fireworkStuff() {
  //fireworkSpwanTimer--;
  //if (fireworkSpwanTimer < 0) {
  //  fireworkList.add(new Firework(random(BS/2, map.width*BS), 0, random(BS/2, map.height*BS), 0, -1, 0, 25, 0));
  //  fireworkSpwanTimer = 120;
  //}

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

void snowStuff() {
  snowList.add(new Snow(random(BS/2, map.width*BS), -500, random(BS/2, map.height*BS), random(-2, 2), 1, random(-2, 2), 2));

  for (int i = 0; i < snowList.size(); i++) {
    Snow tempSnow = snowList.get(i);
    tempSnow.show();
    tempSnow.act();
    if (tempSnow.loc.y > BS) snowList.remove(i);
  }
}//----------------------------------------------------------------------------------------------------------------

void creeperStuff() {
  csTimer--;
  if (csTimer < 0){
   float angle = random(0, 360);
   PVector spawnPoint = new PVector(map.width*BS/2, map.height*BS/2);
   spawnPoint.rotate(angle);
   spawnPoint.add(30, 30);
    creeperList.add(new Creeper(spawnPoint.x, 0, spawnPoint.z, 20));
    csTimer = 180;
  }
  
  for (int i = 0; i < creeperList.size(); i++) {
    Creeper tempCreeper = creeperList.get(i);
    tempCreeper.show();
    tempCreeper.act();

    if (dist(tempCreeper.loc.x, tempCreeper.loc.z, lx, lz) < 100) {
      for (int j = 0; j < 50; j++) {
        fireworkList.add(new Firework(lx, ly-4*tempCreeper.s, lz, random(-1, 1), random(-1, 1), random(-1, 1), 4, 100));
      }
      creeperList.remove(i);
    }
    println(fireworkList.size());
  }//----------------------------------------------------------------------------------------------------------------
}
