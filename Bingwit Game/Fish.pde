PImage fish1, fish2, fish3, sprite;

class Fish extends SeaObject {
  int speed;

  Fish(int id, float xLoc, float yLoc, int size, int value, int speed) {
    this.id = id;
    this.xLoc = xLoc;
    this.yLoc = yLoc;
    this.size = size;
    this.value = value;
    this.speed = speed;
    this.isCaught = false;

    if (id == 1) sprite = fish1;
    else if (id == 2) sprite = fish2;
    else sprite = fish3;
  }
  
  void display() {
    pushMatrix();
    translate(xLoc, yLoc);
    if (speed < 0) {
      scale(-1, 1);
      image(sprite, -size, 0, size, size);
    } else {
      image(sprite, 0, 0, size, size);
    }
    popMatrix();
    
    xLoc += speed;

    if (xLoc > (width - 50) - size || xLoc < 50) {
      speed *= -1;
    }
}


  void applyKita() {
  }
  
}
