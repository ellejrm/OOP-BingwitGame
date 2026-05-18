float reelSpeed = 0, normalLength = 150, extendedLength = 150, extendSpeed = 2.5, castAngle = 0;
boolean casting = false, retracting = false;

void drawFishingHook() {
  float lineX = 538;
  float lineY = 210;
  pushMatrix();
  translate(lineX, lineY); //so that one end of the line remains static

  if(!casting){ //swings when it's not casting
    float swing = radians(75) * sin(reelSpeed);
    rotate(swing);
    reelSpeed += 0.01; //speed of swing
  } else {
    rotate(castAngle); //stores the angle 
  }
  
  strokeWeight(3);
  stroke(212, 166, 60);
  line(0, 0, 0, extendedLength);

  image(hook, -30, extendedLength, 50, 50);
  popMatrix();
 
  if (casting && !retracting) { //casting
    extendedLength += extendSpeed; //speed of extension
    if (extendedLength >= height) { //extends
      retracting = true;
    }
  } else if (casting && retracting) {//retracts
    extendedLength -= extendSpeed;
    if (extendedLength <= normalLength) {//checks if nasa normal length na uli
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
  }
}
