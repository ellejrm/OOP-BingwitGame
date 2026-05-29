PImage fish1, fish2, fish3, sprite;

class Fish extends SeaObject {
  private int speed;
  PImage sprite;

  Fish(int id, float xLoc, float yLoc, int size, int value, int speed) {
    super(id, xLoc, yLoc, size, value);
    
    this.speed = speed;

    if (id == 1) sprite = fish1;
    else if (id == 2) sprite = fish2;
    else sprite = fish3;
  }
  
  void setSpeed(int speed) {
    this.speed = speed;
  }

  int getSpeed() {
    return this.speed;
  }

  @Override
  void display() {
    float currentX = getXLoc();
    float currentY = getYLoc();
    int currentSize = getSize();

    if (!isCaught) {
      pushMatrix();
      translate(currentX, currentY);
      if (speed < 0) {
        scale(-1, 1);
        image(sprite, -currentSize, 0, currentSize, currentSize);
      } else {
        image(sprite, 0, 0, currentSize, currentSize);
      }
      popMatrix();

      currentX += speed;      
      float leftBound = 50;
      float rightBound = (width - 50) - currentSize;
      
      if (currentX > rightBound) {
        currentX = rightBound;
        speed *= -1;
      }
      
      if (currentX < leftBound) {
        currentX = leftBound;
        speed *= -1;
      }
      
      setXLoc(currentX);
      
    } else {
      tint(255, alpha);
      image(sprite, hookTipX - currentSize/2, hookTipY - currentSize/2, currentSize, currentSize);
      noTint();
    }
  }
  
  @Override
  void checkCatch() {
    this.isCaught = true;
    this.applyKita();
    retracting = true;
    casting = true;
    caughtThisCast = true;
    caughtSomething = true;
    
    if (castAngle < 0) {
      catchOffsetX += -20;
      catchOffsetY -= 30;
      currentAvatar = danao_rc;
    } else {
      catchOffsetX += 0;
      catchOffsetY -= 30;
      currentAvatar = danao_lc;
    }
  }

  @Override
  void applyKita() {
    currentKita += getValue();
    fishCaught++;
    fishScore += getValue();
  }
}
