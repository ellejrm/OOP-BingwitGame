PImage debris;

class Debris extends SeaObject {
  float scaleX = 1.0;
  float scaleY = 1.0;

  Debris(float x, float y) {
    super(-1, x, y, 100, -50); 
    
    if (random(1) < 0.5) scaleX = -1.0;
    if (random(1) < 0.5) scaleY = -1.0;
  }

  @Override
  void display() {
    if (removed) return;

    pushMatrix();

    float currentX = getXLoc();
    float currentY = getYLoc();
    int currentSize = getSize();

    if (!isCaught) {
      translate(currentX + currentSize * 0.5, currentY + currentSize * 0.5);
      scale(scaleX, scaleY);
      
      if (debris != null) {
        image(debris, -currentSize * 0.5, -currentSize * 0.5, currentSize, currentSize);
      } else {
        fill(120);
        rect(-currentSize * 0.5, -currentSize * 0.5, currentSize, currentSize);
      }
    } else {
      translate(hookTipX, hookTipY);
      scale(scaleX, scaleY);
      
      if (debris != null) {
        if (alpha < 255) tint(255, alpha);
        image(debris, -currentSize * 0.5, -currentSize * 0.5, currentSize, currentSize);
        if (alpha < 255) noTint();
      } else {
        fill(120, alpha);
        rect(-currentSize * 0.5, -currentSize * 0.5, currentSize, currentSize);
      }
    }

    popMatrix();
  }
  
  @Override
  void checkCatch() {
    this.isCaught = true;
    this.applyKita();
    println("Hit debris");
  
    retracting = true;   
    caughtThisCast = true;
    
    currentRetractSpeed = 1.5;
  
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
    debrisCaught++;
    debrisScore += getValue();
  }
}
