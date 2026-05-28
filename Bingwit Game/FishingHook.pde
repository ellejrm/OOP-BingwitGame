float reelSpeed = 0, normalLength = 80, extendedLength = 150, extendSpeed = 3, currentRetractSpeed = 3, swingSpeed = 0.02, castAngle = 0;
boolean casting = false, retracting = false;
float lineX = 640;
float lineY = 210;
float hookTipX, hookTipY;

void drawFishingHook() {
  pushMatrix();
  translate(lineX + catchOffsetX, lineY + catchOffsetY);

  if (!casting) {
    float swing = radians(75) * sin(reelSpeed);
    rotate(swing);
    reelSpeed += swingSpeed;
    castAngle = swing;
  } else {
    rotate(castAngle);
  }
  if (!caughtSomething) {
    if (castAngle < 0) {
      currentAvatar = danao_r;
    } else {
      currentAvatar = danao_l;
    }
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
      currentRetractSpeed = extendSpeed;
    }
  } else if (casting && retracting) {
    
    extendedLength -= currentRetractSpeed; 
    
    if (extendedLength <= normalLength) {
      extendedLength = normalLength;
      casting = false;
      retracting = false;
      
      if (extendedLength <= normalLength) {
        extendedLength = normalLength;   
        casting = false;
        retracting = false;
        readyToFade = true;   
        caughtThisCast = false;
        caughtSomething = false;   
        catchOffsetX = 0;
        catchOffsetY = 0;

        currentRetractSpeed = extendSpeed; 
        
        if (!caughtSomething) {
          if (castAngle < 0) {
            currentAvatar = danao_r; 
          } else {
            currentAvatar = danao_l;
          }
        }
      }
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
