PImage mainbg, logo, play, levels, gamebg, backhome, lvlbg, lvl1, lvl2, lvl3, avatar, hook, store, pause, pausePanel, resume, restart;
PFont gameFont;
int currentLvl = 1, currentKita = 0, targetKita, gameState = 0;
boolean justEnteredGame = false;
ArrayList<Fish> fishes = new ArrayList<Fish>();
ArrayList<Debris> debrisList = new ArrayList<Debris>();
boolean caughtThisCast = false;

Fish createSmallFish(int id, float x, float y) {
  return new Fish(id, x, y, 80, 100, 2); 
}
Fish createBigFish(int id, float x, float y) {
  return new Fish(id, x, y, 150, 50, 1);
}
Debris createDebris(float x, float y) {
  return new Debris(x, y);
}


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
  resume = loadImage("resume.png");
  restart = loadImage("restart.png");
  fish1 = loadImage("fish1.png");
  fish2 = loadImage("fish2.png");
  fish3 = loadImage("fish3.png");
  debris = loadImage("debris.png"); 
  gameFont = createFont("Lazydog.otf", 20);
  
  //fish
  fishes.add(createSmallFish(1, 200, 350));
  fishes.add(createBigFish(2, 400, 450));
  
  debrisList.add(createDebris(1100, 490));
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

for (Fish f : fishes) {
  if (!f.isCaught) {
    f.display();
    if (!f.isCaught && !caughtThisCast && collidesWith(f)) {
      f.isCaught = true;
      f.applyKita();
      println("Caught fish " + f.getID());
      
      retracting = true;
      casting = true;
      caughtThisCast = true;
    }
  } else {
    f.display();

    if (!casting && !retracting && extendedLength == normalLength) {
      f.fadeOut();
    }
  }
}

for (Debris d : debrisList) {
  if (d.removed) continue;
  d.display();

  if (!caughtThisCast && !d.isCaught && collidesWith(d)) {
    d.isCaught = true;
    d.applyKita();
    println("Hit debris");
    retracting = true;   
    caughtThisCast = true;
  }

  if (d.isCaught && !casting && !retracting && extendedLength == normalLength) {
    d.fadeAndRemove();
  }
}
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
    drawResumeButton();
    drawRestartButton();
}
