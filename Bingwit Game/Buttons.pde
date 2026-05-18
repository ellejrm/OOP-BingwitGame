int playX = 515, playY = 400, playW = 250, playH = 145;
int lvlX = 515, lvlY = 500, lvlW = 250, lvlH = 145;
int backHmW = 276, backHmH = 147;
int backHmLvlX = 100, backHmLvlY = 550; //levels
int backHmPauseX = 500, backHmPauseY = 450; //pausePanel
int lvl1X = 385, lvl1Y = 250, lvl1W = 341, lvl1H = 192;
int lvl2X = 585, lvl2Y = 250, lvl2W = 341, lvl2H = 192;
int lvl3X = 785, lvl3Y = 250, lvl3W = 341, lvl3H = 192;
int storeX = 10, storeY = 550, storeW = 300, storeH = 170;
int pauseX = 970, pauseY = 550, pauseW = 300, pauseH = 170;
int screenX = 0, screenY = 0, screenW = 1280, screenH = 720;


void drawPlayButton() {
  if (isHover(playX, playY, playW, playH)) {
    image(play, playX - 5, playY - 5, playW + 10, playH + 10);
  } else {
    image(play, playX, playY, playW, playH);
  }
}

void drawLevelsButton() {
  if (isHover(lvlX, lvlY, lvlW, lvlH)) {
    image(levels, lvlX - 5, lvlY - 5, lvlW + 10, lvlH + 10);
  } else {
    image(levels, lvlX, lvlY, lvlW, lvlH);
  }
}

void drawBackHomeLvlButton() {
  if (isHover(backHmLvlX, backHmLvlY, backHmW, backHmH)) {
    image(backhome, backHmLvlX - 5, backHmLvlY - 5, backHmW + 10, backHmH + 10);
  } else {
    image(backhome, backHmLvlX, backHmLvlY, backHmW, backHmH);
  }
}

void drawBackHomePauseButton() {
  if (isHover(backHmPauseX, backHmPauseY, backHmW, backHmH)) {
    image(backhome, backHmPauseX - 5, backHmPauseY - 5, backHmW + 10, backHmH + 10);
  } else {
    image(backhome, backHmPauseX, backHmPauseY, backHmW, backHmH);
  }
}

void drawLvl1Button() {
    if (isHover(lvl1X, lvl1Y, lvl1W, lvl1H)) {
    image(lvl1, lvl1X - 5, lvl1Y - 5, lvl1W + 10, lvl1H + 10);
  } else {
    image(lvl1, lvl1X, lvl1Y, lvl1W, lvl1H);
  }
}

void drawLvl2Button() {
    if (isHover(lvl2X, lvl2Y, lvl2W, lvl2H)) {
    image(lvl2, lvl2X - 5, lvl2Y - 5, lvl2W + 10, lvl2H + 10);
  } else {
    image(lvl2, lvl2X, lvl2Y, lvl2W, lvl2H);
  }
}

void drawLvl3Button() {
    if (isHover(lvl3X, lvl3Y, lvl3W, lvl3H)) {
    image(lvl3, lvl3X - 5, lvl3Y - 5, lvl3W + 10, lvl3H + 10);
  } else {
    image(lvl3, lvl3X, lvl3Y, lvl3W, lvl3H);
  }
}

void drawStoreButton() {
    if (isHover(storeX, storeY, storeW, storeH)) {
    image(store, storeX - 5, storeY - 5, storeW + 10, storeH + 10);
  } else {
    image(store, storeX, storeY, storeW, storeH);
  }
}

void drawPauseButton() {
    if (isHover(pauseX, pauseY, pauseW, pauseH)) {
      image(pause, pauseX - 5, pauseY - 5, pauseW + 10, pauseH + 10);
  } else {
    image(pause, pauseX, pauseY, pauseW, pauseH);
  }
}

void mousePressed() {
  if (gameState == 0 && isHover(playX, playY, playW, playH)) {
    gameState = 1;
    gameStartTime = millis();
    justEnteredGame = true;
  }
  if (gameState == 0 && isHover(lvlX, lvlY, lvlW, lvlH)) {
    gameState = 2;
  }
  if (gameState == 2 && isHover(backHmLvlX, backHmLvlY, backHmW, backHmH)) {
    gameState = 0;
  }
  if (gameState == 3 && isHover(backHmPauseX, backHmPauseY, backHmW, backHmH)) {
    gameState = 0;
  }
  if (gameState == 2 && isHover(lvl1X, lvl1Y, lvl1W, lvl1H)) {
    gameState = 1;
    gameStartTime = millis();
    justEnteredGame = true;
  }
  if (gameState == 2 && isHover(lvl2X, lvl2Y, lvl2W, lvl2H)) {
    currentLvl = 2;
    gameState = 1;
    gameStartTime = millis();
    justEnteredGame = true;
  }
  if (gameState == 2 && isHover(lvl3X, lvl3Y, lvl3W, lvl3H)) {
    currentLvl = 3;
    gameState = 1;
    gameStartTime = millis();
    justEnteredGame = true;
  }
  if (gameState == 1 && isHover(storeX, storeY, storeW, storeH)) {
    gameState = 0;
  }
  if (gameState == 1 && isHover(pauseX, pauseY, pauseW, pauseH)) {
    gameState = 3;
    pauseTimer();
  }
  if (gameState == 1 && !justEnteredGame && isHover(screenX, screenY, screenW, screenH)) {
    cast();
  }
}


boolean isHover(int x, int y, int w, int h) {
  return mouseX > x &&
         mouseX < x + w &&
         mouseY > y &&
         mouseY < y + h;
}
