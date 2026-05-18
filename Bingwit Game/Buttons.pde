int playX = 515, playY = 400, playW = 250, playH = 145;
int lvlX = 515, lvlY = 500, lvlW = 250, lvlH = 145;
int backHmX = 100, backHmY = 550, backHmW = 276, backHmH = 147;
int lvl1X = 385, lvl1Y = 250, lvl1W = 341, lvl1H = 192;
int lvl2X = 585, lvl2Y = 250, lvl2W = 341, lvl2H = 192;
int lvl3X = 785, lvl3Y = 250, lvl3W = 341, lvl3H = 192;

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

void drawBackHomeButton() {
  if (isHover(backHmX, backHmY, backHmW, backHmH)) {
    image(backhome, backHmX - 5, backHmY - 5, backHmW + 10, backHmH + 10);
  } else {
    image(backhome, backHmX, backHmY, backHmW, backHmH);
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



void mousePressed() {
  if (gameState == 0 && isHover(playX, playY, playW, playH)) {
    gameState = 1;
  }
  if (gameState == 0 && isHover(lvlX, lvlY, lvlW, lvlH)) {
    gameState = 2;
  }
  if (gameState == 2 && isHover(backHmX, backHmY, backHmW, backHmH)) {
    gameState = 0;
  }
  if (gameState == 2 && isHover(lvl1X, lvl1Y, lvl1W, lvl1H)) {
    gameState = 1;
  }
  if (gameState == 2 && isHover(lvl2X, lvl2Y, lvl2W, lvl2H)) {
    currentLvl = 2;
    gameState = 1;
  }
  if (gameState == 2 && isHover(lvl3X, lvl3Y, lvl3W, lvl3H)) {
    currentLvl = 3;
    gameState = 1;
  }
}


boolean isHover(int x, int y, int w, int h) {
  return mouseX > x &&
         mouseX < x + w &&
         mouseY > y &&
         mouseY < y + h;
}
