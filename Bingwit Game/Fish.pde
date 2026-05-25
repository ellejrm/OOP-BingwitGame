PImage fish1, fish2, fish3, sprite;

class Fish extends SeaObject {
  boolean removed = false;
  int speed;
  PImage sprite;
  int alpha = 255; //  for fading of the fish when caught

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

  @Override
  void display() {
    if (!isCaught) {
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
      float leftBound = 50;
      float rightBound = (width - 50) - size;
      
      if (xLoc > rightBound) {
        xLoc = rightBound;
        speed *= -1;
      }
      
      if (xLoc < leftBound) {
        xLoc = leftBound;
        speed *= -1;
      }
    } else {
      tint(255, alpha);
      image(sprite, hookTipX - size/2, hookTipY - size/2, size, size);
      noTint();
    }
  }
  
  void fadeAndRemove() {
    if (alpha > 0) {
      alpha -= 12;
      if (alpha < 0) alpha = 0;
    }
    if (alpha == 0) removed = true;
  }

  @Override
  void applyKita() {
    currentKita += value;
    fishCaught++;
    fishScore += value;
  }
}
