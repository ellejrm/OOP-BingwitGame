PImage mainbg, logo, play, levels, gamebg, backhome, lvlbg, lvl1, lvl2, lvl3;
PFont gameFont;
int currentLvl = 1, goal, kita;

int gameState = 0;

void setup() {
  size(1280, 720);

  mainbg = loadImage("mainbg.png");
  logo   = loadImage("bingwitlogo.png");
  play   = loadImage("play.png");
  levels = loadImage("levels.png");
  gamebg = loadImage("gamebg.png");
  backhome = loadImage("backhome.png");
  lvlbg = loadImage("levelsbg.png");
  lvl1 = loadImage("level1.png");
  lvl2 = loadImage("level2.png");
  lvl3 = loadImage("level3.png");
  gameFont = createFont("Lazydog.otf", 20);
}

void draw() {

  if (gameState == 0) {
    drawMainMenu();
  } else if (gameState == 1) {
    drawGame();
  } else if (gameState == 2) {
    drawLevels();
  }
}


void drawMainMenu() {
  image(mainbg, 0, 0, width, height);
  image(logo, 410, 130, 470, 250);

  drawPlayButton();
  drawLevelsButton();
}

void drawGame() {
  image(gamebg, 0, 0, width, height);
  image(logo, 546, 10, 184, 98);
  fill(253, 197, 76);
  rect(30, 20, 180, 40);
  fill(253, 197, 76);
  rect(235, 20, 200, 40);
  fill(253, 197, 76);
  rect(30, 20, 180, 40);
  fill(253, 197, 76);
  rect(30, 20, 180, 40);
    
  if (currentLvl == 1) {
    goal = 1000;
  } else if (currentLvl == 2) {
    goal = 2500;
  } else if (currentLvl == 3) {
    goal = 5000;
  }

  fill(0, 0, 0);
  textFont(gameFont);
  text("LEVEL " + currentLvl, 80, 48);  
  startTime();
}


void drawLevels() {
  image(mainbg, 0, 0, width, height);
  image(logo, 100, 50, 276, 147);
  image(lvlbg, 400, 87, 720, 546);
  
  drawBackHomeButton();
  drawLvl1Button();
  drawLvl2Button();
  drawLvl3Button();
}
