float reelSpeed = 0, normalLength = 150, extendedLength = 150, extendSpeed = 2.5, castAngle = 0;
boolean casting = false, retracting = false;
float lineX = 538;
float lineY = 210;
float hookTipX, hookTipY;

void drawFishingHook() {
  pushMatrix();
  translate(lineX, lineY);

  if (!casting) {
    float swing = radians(75) * sin(reelSpeed);
    rotate(swing);
    reelSpeed += 0.01;
    castAngle = swing;
  } else {
    rotate(castAngle);
  }
  
  strokeWeight(3);
  stroke(212, 166, 60);
  line(0, 0, 0, extendedLength);

  image(hook, -30, extendedLength, 50, 50);
  hookTipX = lineX - extendedLength * sin(castAngle);
  hookTipY = lineY + extendedLength * cos(castAngle);

  popMatrix();
 
if (casting && !retracting) {
  extendedLength += extendSpeed;
  if (extendedLength >= height) {
    retracting = true;
  }
  } else if (casting && retracting) {
    extendedLength -= extendSpeed;
    if (extendedLength <= normalLength) {
      extendedLength = normalLength;
      casting = false;
      retracting = false;
    }
  }
}

void cast() {
  if (!casting) {
    casting = true;
    retracting = false;
    extendedLength = normalLength;
    castAngle = radians(75) * sin(reelSpeed);
    caughtThisCast = false;
  }
}

boolean collidesWith(SeaObject obj) {
  float fx = obj.getXLoc() + obj.getSize() * 0.5;
  float fy = obj.getYLoc() + obj.getSize() * 0.5;
  float r = obj.getSize() * 0.5;
  float d = dist(hookTipX, hookTipY, fx, fy);
  return d <= r;
}
