PImage debris;

class Debris extends SeaObject {
  boolean removed = false;
  int alpha = 255;

  Debris(float x, float y) {
    this.id = -1;
    this.xLoc = x;
    this.yLoc = y;
    this.size = 100;
    this.value = -50;
    this.isCaught = false;
  }

  @Override
  void display() {
    if (removed) return;

    if (!isCaught) {
      if (debris != null) image(debris, xLoc, yLoc, size, size);
      else {
        fill(120);
        rect(xLoc, yLoc, size, size);
      }
    } else {
      if (debris != null) {
        if (alpha < 255) tint(255, alpha);
        image(debris, hookTipX - size * 0.5, hookTipY - size * 0.5, size, size);
        if (alpha < 255) noTint();
      } else {
        fill(120, alpha);
        rect(hookTipX - size * 0.5, hookTipY - size * 0.5, size, size);
      }
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
  }
}
