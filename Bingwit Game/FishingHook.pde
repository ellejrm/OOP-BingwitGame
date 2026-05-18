float angle = 0;

void drawFishingHook() {
  // fixed point near avatar
  float hookX = 538;
  float hookY = 210;
  pushMatrix();
  translate(hookX, hookY);

  float swing = radians(50) * sin(angle);
  rotate(swing);
  strokeWeight(3);
  stroke(212, 166, 60);
  line(0, 0, 0, 200);
  popMatrix();
  angle += 0.01;
}
