abstract class SeaObject {
  private int id;
  private float xLoc;
  private float yLoc;
  private int size;
  private int value;
  
  boolean isCaught;
  int alpha = 255;
  boolean removed = false;

  SeaObject(int id, float x, float y, int size, int value) {
    this.id = id;
    this.xLoc = x;
    this.yLoc = y;
    this.size = size;
    this.value = value;
    this.isCaught = false;
  }

  // methods
  abstract void display();
  abstract void applyKita();
  abstract void checkCatch();
  
  void fadeAndRemove() {
    if (alpha > 0) {
      alpha -= 12;
      if (alpha < 0) alpha = 0;
    }
    if (alpha == 0) removed = true;
  }

  void setID(int id) { this.id = id; }
  int getID() { return id; }

  void setXLoc(float xLoc) { this.xLoc = xLoc; }
  float getXLoc() { return xLoc; }

  void setYLoc(float yLoc) { this.yLoc = yLoc; }
  float getYLoc() { return yLoc; }

  void setSize(int size) { this.size = size; }
  int getSize() { return size; }

  void setValue(int value) { this.value = value; }
  int getValue() { return value; }
}


  void spawnObjects() {
    fishes.clear();
    debrisList.clear();
    treasures.clear();
    int numBigFish = 2, numSmallFish = 3, numDebris = 2, numTreasure = 2;
    
    if (currentLvl == 1) {
      numBigFish = 2;
      numSmallFish = 3;
      numDebris = 2;
      numTreasure = 2;
    } else if (currentLvl == 2) {
      numBigFish = 3;
      numSmallFish = 4;
      numDebris = 4;
      numTreasure = 3;
    } else if (currentLvl == 3) {
      numBigFish = 4;
      numSmallFish = 5;
      numDebris = 6;
      numTreasure = 2;
    }
  
    for (int i = 0; i < numBigFish; i++) {
      int randomId = int(random(1, 4)); 
      fishes.add(createBigFish(randomId, random(spawnXMin, spawnXMax), random(spawnYMin, spawnYMax)));
    }
    
    for (int i = 0; i < numSmallFish; i++) {
      int randomId = int(random(1, 4)); 
      fishes.add(createSmallFish(randomId, random(spawnXMin, spawnXMax), random(spawnYMin, spawnYMax)));
    }
    
    for (int i = 0; i < numDebris; i++) {
      debrisList.add(new Debris(random(spawnXMin, spawnXMax), random(spawnYMin, spawnYMax)));
    }
    
    for (int i = 0; i < numTreasure; i++) {
      treasures.add(new Treasure(random(spawnXMin, spawnXMax), random(spawnYMin, spawnYMax)));
    }
  }
  
  void checkAndRespawnObjects() {
    int activeFishes = 0;
    int activeItems = 0;
  
    for (Fish f : fishes) {
      if (!f.isCaught) activeFishes++;
    }

    for (Treasure t : treasures) {
      if (!t.isCaught && !t.removed) activeItems++;
    }
  
    for (Debris d : debrisList) {
      if (!d.isCaught && !d.removed) activeItems++;
    }
    
    int totalActiveObjects = activeFishes + activeItems;
  
    
    float rx = random(spawnXMin, spawnXMax);
    float ry = random(spawnYMin, spawnYMax);
    int randomId = int(random(1, 4));
  
    if (activeFishes <= 1) {
      if (random(1) < 0.5) {
        fishes.add(createSmallFish(randomId, rx, ry));
      } else {
        fishes.add(createBigFish(randomId, rx, ry));
      }
      println("Fish pool critical! Guaranteed a fresh fish respawn.");
    }
    
    else if (totalActiveObjects <= 2) {
      float randomType = random(1);
      
      if (randomType < 0.7) { 
        treasures.add(new Treasure(rx, ry));
        println("Low items! Respawned a treasure coin.");
      } else { 
        debrisList.add(new Debris(rx, ry));
        println("Low items! Respawned debris.");
      }
    }
  }
