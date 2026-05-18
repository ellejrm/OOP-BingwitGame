int gameStartTime;
int timeLimit = 60;

void drawTimer() {
  int elapsedTime = (millis() - gameStartTime) / 1000;
  int remainingTime = timeLimit - elapsedTime;
  remainingTime = max(0, remainingTime);
  
  fill(0, 0, 0);
  textFont(gameFont);
  text("TIME LEFT: " + remainingTime, 270, 48);
}
