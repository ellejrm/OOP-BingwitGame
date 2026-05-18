int startTime;
int timeLimit = 60;

void startTime() {

  int elapsedTime = (millis() - startTime) / 1000;
  int remainingTime = timeLimit - elapsedTime;
  remainingTime = max(0, remainingTime);
  
  fill(0, 0, 0);
  textFont(gameFont);
  text("TIME LEFT: " + remainingTime, 270, 48);
}
