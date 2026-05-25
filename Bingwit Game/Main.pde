PImage mainbg, logo, play, levels, gamebg, backhome, lvlbg, lvl1, lvl2, lvl3, danao_l, danao_r, danao_lc, danao_rc, currentAvatar, hook, store, pause, pausePanel, resume, restart, win, lose, coin;
PFont gameFont; //initializations
int currentLvl = 1, currentKita = 0, targetKita, gameState = 0, avatarBaseX = 615, avatarOffsetX = -215;
float catchOffsetX = 0, catchOffsetY = 0;
boolean justEnteredGame = false;
boolean caughtThisCast = false, caughtSomething = false;
boolean readyToFade = false;
ArrayList<Fish> fishes = new ArrayList<Fish>();
ArrayList<Debris> debrisList = new ArrayList<Debris>();
ArrayList<Treasure> treasures = new ArrayList<Treasure>();
int spawnXMin = 10, spawnXMax = 1190;
int spawnYMin = 350, spawnYMax = 600;

Fish createSmallFish(int id, float x, float y) {
  int dir = random(1) < 0.5 ? -2 : 2;
  return new Fish(id, x, y, 80, 100, dir);
}

Fish createBigFish(int id, float x, float y) {
  int dir = random(1) < 0.5 ? -1 : 1;
  return new Fish(id, x, y, 150, 50, dir);
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
  danao_l = loadImage("danaoleft.png");
  danao_lc = loadImage("danaoleftc.png");
  danao_r = loadImage("danaoright.png");
  danao_rc = loadImage("danaorightc.png");
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
  coin = loadImage("coin.png");
  win = loadImage("winscreen.png"); 
  lose = loadImage("losescreen.png"); 
  gameFont = createFont("Lazydog.otf", 20);
  currentAvatar = danao_l;
    
  fishes.add(createBigFish(1, random(spawnXMin, spawnXMax), random(spawnYMin, spawnYMax)));
  fishes.add(createBigFish(3, random(spawnXMin, spawnXMax), random(spawnYMin, spawnYMax)));
  fishes.add(createSmallFish(3, random(spawnXMin, spawnXMax), random(spawnYMin, spawnYMax)));
  fishes.add(createSmallFish(1, random(spawnXMin, spawnXMax), random(spawnYMin, spawnYMax)));
  fishes.add(createSmallFish(2, random(spawnXMin, spawnXMax), random(spawnYMin, spawnYMax)));
  
  treasures.add(new Treasure(random(spawnXMin, spawnXMax), random(spawnYMin, spawnYMax)));
  treasures.add(new Treasure(random(spawnXMin, spawnXMax), random(spawnYMin, spawnYMax)));

  debrisList.add(new Debris(random(spawnXMin, spawnXMax), random(spawnYMin, spawnYMax)));
  debrisList.add(new Debris(random(spawnXMin, spawnXMax), random(spawnYMin, spawnYMax)));
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
  } else if (gameState == 4) {
    drawWinPanel();
  } else if (gameState == 5) {
    drawLosePanel();
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
  if (currentAvatar == danao_r || currentAvatar == danao_rc) {
    image(currentAvatar, avatarBaseX + avatarOffsetX, 80, 250, 250);
  } else {
    image(currentAvatar, avatarBaseX, 80, 250, 250);
  }
  fill(253, 197, 76);
  rect(30, 20, 180, 40);
  rect(235, 20, 200, 40);
  rect(840, 20, 200, 40);
  rect(1070, 20, 180, 40);
  
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

  f.display();

  if (!f.isCaught && !caughtThisCast && collidesWith(f)) {

    f.isCaught = true;
    f.applyKita();

    retracting = true;
    casting = true;
    caughtThisCast = true;

    if (castAngle < 0) {
      catchOffsetX += -20;
      catchOffsetY -= 30;
      currentAvatar = danao_rc;
    } else {
      catchOffsetX += 0;
      catchOffsetY -= 30;
      currentAvatar = danao_lc;
    }

    caughtSomething = true;
  }

  if (f.isCaught && !casting && !retracting && extendedLength == normalLength) {
    f.fadeAndRemove();
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
  
    if (castAngle < 0) {
      catchOffsetX += -20;
      catchOffsetY -= 30;
      currentAvatar = danao_rc;
    } else {
      catchOffsetX += 0;
      catchOffsetY -= 30;
      currentAvatar = danao_lc;
    }
    caughtSomething = true;
  }

  if (d.isCaught && !casting && !retracting && extendedLength == normalLength) {
    d.fadeAndRemove();
  }
}

if (currentKita >= targetKita) {
  gameState = 4; // win panel
} else if (getTimeRemaining() <= 0 && currentKita < targetKita) {
  gameState = 5; // lose panel
}

for (Treasure t : treasures) {
  if (t.removed) continue;
  t.display();

  if (!caughtThisCast && !t.isCaught && collidesWith(t)) {
    t.isCaught = true;
    t.applyKita();
    println("Got treasure!");

    retracting = true;
    if (castAngle < 0) {
      catchOffsetX += -20;
      catchOffsetY -= 30;
      currentAvatar = danao_rc;
    } else {
      catchOffsetX += 0;
      catchOffsetY -= 30;
      currentAvatar = danao_lc;
    }
    caughtSomething = true;
  }

  if (t.isCaught && !casting && !retracting && extendedLength == normalLength) {
    t.fadeAndRemove();
  }
} 
  drawStoreButton();
  drawPauseButton();
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

void drawWinPanel() {  
  image(win, 320, 118, 640, 484);
  textFont(gameFont);
  textSize(30);
  text("FISHES CAUGHT: " + fishCaught, 350, 275);
  text("COINS OBTAINED: " + treasureCaught, 350, 305);
  text("DEBRIS CAUGHT: " + debrisCaught, 350, 335);
 
  text("+ " + fishScore, 750, 275);
  text("+ " + treasureScore, 750, 305);
  text(debrisScore, 750, 335);
  
  text("TOTAL KITA: ", 350, 420);
  text(currentKita, 750, 420);
  text("TIME LEFT: ", 350, 450);
  text(pausedTime, 750, 450);
}

void drawLosePanel() {
  image(lose, 320, 118, 640, 484);
  textFont(gameFont);
  textSize(30);
  text("FISHES CAUGHT: " + fishCaught, 350, 275);
  text("COINS OBTAINED: " + treasureCaught, 350, 305);
  text("DEBRIS CAUGHT: " + debrisCaught, 350, 335);
  
  text("+" + fishScore, 750, 275);
  text("+" + treasureScore, 750, 305);
  text(debrisScore, 750, 335);
  
  text("TOTAL KITA: ", 350, 420);
  text(currentKita, 750, 420);
  text("TIME LEFT: ", 350, 450);
  text(pausedTime, 750, 450);
}
