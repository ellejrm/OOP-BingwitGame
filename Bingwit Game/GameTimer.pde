int gameStartTime;
int timeLimit = 60; //countdown
int pausedTime = 0; //the time left when u paused the game
boolean timerRunning = true;

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
  text("TIME LEFT: " + timeLeft, 300, 48);

  if (timeLeft == 0) {
    gameState = 0; //may lose/win panel dito, placeholder muna
  }
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
