import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import ddf.minim.*;
PImage mainbg, logo, gamebg, danao_l, danao_r, danao_lc, danao_rc, currentAvatar, hook, pausePanel, win, lose, storebg, storepanel, storeicon1, storeicon2;
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
int spawnYMin = 300, spawnYMax = 500;

Minim minim;
AudioPlayer bgm, waves, storebgm, gamebgm;
AudioSample clickSound, whooshSound, kachingSound, loseSound, winSound;

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
  storebg = loadImage("storebg.png"); 
  storepanel = loadImage("storepanel.png");
  storeicon1 = loadImage("storeicon1.png");
  storeicon2 = loadImage("storeicon2.png");
  backstore = loadImage("backtogame.png");
  playagain   = loadImage("playagain.png");
  buy = loadImage("buy.png");
  next = loadImage("next.png");
  
  gameFont = createFont("Lazydog.otf", 20);
  currentAvatar = danao_l;
  
  minim = new Minim(this);
  
  bgm = minim.loadFile("mainmenubgm.mp3");
  bgm.setGain(0);
  waves = minim.loadFile("wavesfx.mp3");
  bgm.setGain(-5.0);
  waves.loop();
  bgm.loop();
  storebgm = minim.loadFile("storebgm.mp3");
  storebgm.setGain(5);
  gamebgm = minim.loadFile("gamebgm.mp3");
  gamebgm.setGain(5);
  
  clickSound = minim.loadSample("clicksfx.mp3"); 
  clickSound.setGain(-5.0);
  whooshSound = minim.loadSample("whooshsfx.mp3"); 
  whooshSound.setGain(-8.0);
  kachingSound = minim.loadSample("kachingsfx.mp3"); 
  kachingSound.setGain(-8.0);
  loseSound = minim.loadSample("losesfx.mp3"); 
  loseSound.setGain(-8.0);
  winSound = minim.loadSample("winsfx.mp3"); 
  winSound.setGain(-8.0);
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
  } else if (gameState == 6) {
    drawStore();
  } else if (gameState == 7) {
    drawEndPanel();
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

  if (!f.isCaught && !caughtThisCast && !retracting && collidesWith(f)) {
    f.checkCatch();
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
    d.checkCatch();
    caughtSomething = true;
  }

  if (d.isCaught && !casting && !retracting && extendedLength == normalLength) {
    d.fadeAndRemove();
  }
}

for (Treasure t : treasures) {
  if (t.removed) continue;
  t.display();

  if (!caughtThisCast && !t.isCaught && collidesWith(t)) {
    t.checkCatch();
    caughtSomething = true;
  }

  if (t.isCaught && !casting && !retracting && extendedLength == normalLength) {
    t.fadeAndRemove();
  }
} 

  if (getTimeRemaining() > 0) { 
      checkAndRespawnObjects();
    }

  if (currentKita >= targetKita && extendedLength == normalLength) {
    winSound.trigger();
    gamebgm.pause();
    gameState = 4; // win panel
  } else if (getTimeRemaining() <= 0 && currentKita < targetKita) {
    loseSound.trigger();
    gamebgm.pause();
    gameState = 5; // lose panel
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
  
  drawStoreButton();
}

void drawWinPanel() {
  if (timerRunning) {
    pauseTimer();
  }
  
  image(win, 320, 118, 640, 484);
  textFont(gameFont);
  textSize(30);
  text("FISHES CAUGHT: " + fishCaught, 400, 275);
  text("COINS OBTAINED: " + treasureCaught, 400, 305);
  text("DEBRIS CAUGHT: " + debrisCaught, 400, 335);
  text("+ " + fishScore, 800, 275);
  text("+ " + treasureScore, 800, 305);
  text(debrisScore, 800, 335);
  
  text("TOTAL KITA: ", 400, 420);
  text(currentKita, 800, 420);
  text("TIME LEFT: ", 400, 450);
  text(getTimeRemaining(), 800, 450);
  
  drawPlayAgainButton();
  drawBackHmWLButton();
  drawNextButton();
  
  if (currentLvl == 3) {
    drawEndPanel();
  }
}

void drawLosePanel() {
  image(lose, 320, 118, 640, 484);
  textFont(gameFont);
  textSize(30);
  text("FISHES CAUGHT: " + fishCaught, 400, 275);
  text("COINS OBTAINED: " + treasureCaught, 400, 305);
  text("DEBRIS CAUGHT: " + debrisCaught, 400, 335);
  
  text("+" + fishScore, 800, 275);
  text("+" + treasureScore, 800, 305);
  text(debrisScore, 800, 335);
  
  text("TOTAL KITA: ", 400, 420);
  text(currentKita, 800, 420);
  text("TIME LEFT: ", 400, 450);
  text(pausedTime, 800, 450);
  
  drawPlayAgainButton();
  drawBackHmWLButton();
  drawNextButton();
}

void drawStore() {
  image(storebg, 0, 0, width, height);
  image(storepanel, 100, 60, 640, 600);
  image(storeicon1, 180, 150, 200, 200);
  image(storeicon2, 450, 150, 200, 200);
  
  fill(253, 197, 76);
  rect(1070, 20, 210, 70);
  
  fill(0);
  text("KITA: " + currentKita, 1115, 65);
  textSize(30);
  text("STOP FISH", 200, 360);
  text("MOVEMENT", 195, 385);
  text("200", 235, 430);
  drawBuyBtn1();
  
  text("SPEED UP", 500, 360);
  text("FISHING ROD", 480, 385);
  text("200", 530, 430);
  drawBuyBtn2();
  drawBackHomeStoreButton(); 
}

void drawEndPanel() {
  fill(253, 197, 76);
  rect(340, 210, 600, 300);
}
