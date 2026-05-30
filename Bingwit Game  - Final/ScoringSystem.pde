int fishCaught = 0;
int fishScore = 0;

int debrisCaught = 0;
int debrisScore = 0;

int treasureCaught = 0;
int treasureScore = 0;


class ScoringSystem {
  int currentKita;
  int targetKita;

  ScoringSystem(int target) {
    currentKita = 0;
    targetKita = target;
  }

  void addScore(int value) {
    currentKita += value;
  }

  boolean hasWon() {
    return currentKita >= targetKita;
  }

  boolean hasLost(int timeRemaining) {
    return timeRemaining <= 0 && currentKita < targetKita;
  }
}
