int gameStartTime;
int timeLimit = 60;
int pausedTime = 0; 
boolean timerRunning = true;

void drawTimer() {
  int elapsed;
  if (timerRunning) {
    elapsed = pausedTime + (millis() - gameStartTime) / 1000;
  } else {
    elapsed = pausedTime / 1000;
  }

  int timeLeft = timeLimit - elapsed; // countdown
  if (timeLeft < 0) timeLeft = 0; 
  text("TIME LEFT: " + timeLeft, 300, 48);
}

void pauseTimer() {
  if (timerRunning) {
    pausedTime += millis() - gameStartTime;
    timerRunning = false;
  }
}

void resumeTimer() {
  if (!timerRunning) {
    gameStartTime = millis();
    timerRunning = true;
  }
}
