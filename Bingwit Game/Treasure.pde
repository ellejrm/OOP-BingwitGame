PImage coin;

class Treasure extends SeaObject {

  Treasure(float x, float y) {
    super(-1, x, y, 100, 30);
  }

  @Override
  void display() {
    if (removed) return;

    float currentX = getXLoc();
    float currentY = getYLoc();
    int currentSize = getSize();

    if (!isCaught) {
      if (coin != null) {
        image(coin, currentX, currentY, currentSize, currentSize);
      } else {
        fill(255, 215, 0); 
        rect(currentX, currentY, currentSize, currentSize);
      }
    } else {
      if (coin != null) {
        if (alpha < 255) tint(255, alpha);
        image(coin, hookTipX - currentSize * 0.5, hookTipY - currentSize * 0.5, currentSize, currentSize);
        if (alpha < 255) noTint();
      } else {
        fill(255, 215, 0, alpha);
        rect(hookTipX - currentSize * 0.5, hookTipY - currentSize * 0.5, currentSize, currentSize);
      }
    }
  }
  
  @Override
  void checkCatch() {
    this.isCaught = true;
    this.applyKita();
    println("Got treasure!");

    retracting = true;
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
    treasureCaught++;
    treasureScore += getValue();
  }
}
