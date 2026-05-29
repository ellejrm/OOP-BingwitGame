int gameStartTime;
int timeLimit = 60; //countdown
int pausedTime = 0; //the time left when u paused the game
boolean timerRunning = true;
int levelDuration = 60000; // 60 seconds per level (adjust as needed)

void drawTimer() {
  int elapsed;
  if (timerRunning) {
    elapsed = pausedTime + (millis() - gameStartTime) / 1000;
  } else {
    elapsed = pausedTime;
  }

  int timeLeft = timeLimit - elapsed;
  if (timeLeft < 0) timeLeft = 0;

  fill(0);
  text("TIME LEFT: " + timeLeft, 270, 48);
}

void pauseTimer() {
  if (timerRunning) {
    pausedTime += (millis() - gameStartTime) / 1000; 
    timerRunning = false;
  }
}

void resumeTimer() {
  if (!timerRunning) {
    gameStartTime = millis(); 
    timerRunning = true;
  }
}

int getTimeRemaining() {
  int elapsed;
  if (timerRunning) {
    elapsed = pausedTime + (millis() - gameStartTime) / 1000;
  } else {
    elapsed = pausedTime;
  }
  int timeLeft = timeLimit - elapsed;
  return max(0, timeLeft);
}
