PImage mainbg, logo, play, levels, gamebg, backhome, lvlbg, lvl1, lvl2, lvl3, avatar, hook, store, pause, pausePanel, resume, restart;
PFont gameFont;
int currentLvl = 1, currentKita = 0, targetKita, gameState = 0;
boolean justEnteredGame = false;

void setup() {
  size(1280, 720);
  smooth(10);
  frameRate(60);
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
  avatar = loadImage("danao&boat.png");
  hook = loadImage("hook.png");
  store = loadImage("storebtn.png");
  pause = loadImage("pause.png");
  pausePanel = loadImage("pausepanel.png");
  gameFont = createFont("Lazydog.otf", 20);
}

void draw() {

  if (gameState == 0) {
    drawMainMenu();
  } else if (gameState == 1) {
    drawGame();
  } else if (gameState == 2) {
    drawLevels();
  } else if (gameState == 3) {
    drawPausePanel();
  }
}


void drawMainMenu() {
  image(mainbg, 0, 0, width, height);
  image(logo, 410, 130, 470, 250);

  drawPlayButton();
  drawLevelsButton();
}

void drawGame() {
  justEnteredGame = false;
  image(gamebg, 0, 0, width, height);
  image(logo, 546, 10, 184, 98);
  image(avatar, 515, 80, 250, 250);
  fill(253, 197, 76);
  rect(30, 20, 180, 40);
  rect(235, 20, 200, 40);
  rect(840, 20, 200, 40);
  rect(1070, 20, 180, 40);
  drawStoreButton();
  drawPauseButton();
    
  if (currentLvl == 1) {
    targetKita = 300;
  } else if (currentLvl == 2) {
    targetKita = 500;
  } else if (currentLvl == 3) {
    targetKita = 700;
  }

  fill(0);
  textFont(gameFont);
  text("LEVEL " + currentLvl, 80, 48);  
  drawTimer();
  text("GOAL: " + targetKita, 885, 48); 
  text("KITA: " + currentKita, 1125, 48); 
  
  drawFishingHook();
}


void drawLevels() {
  image(mainbg, 0, 0, width, height);
  image(logo, 100, 50, 276, 147);
  image(lvlbg, 400, 87, 720, 546);
  
  drawBackHomeLvlButton(); 
  drawLvl1Button();
  drawLvl2Button();
  drawLvl3Button();
}

void drawPausePanel() {
    image(pausePanel, 320, 118, 640, 484);
    drawBackHomePauseButton();
}
