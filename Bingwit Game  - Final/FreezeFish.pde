class FreezeFish extends AlingNenasStore {
  boolean freezeFish = false;
  FreezeFish() {
    super("Freeze Fish: Instantly stops all fish movement!");
  }

  @Override
  int upgradeCost() {
    return 200; 
  }

  @Override
  void upgradeEffect() {
    this.freezeFish = true;
    
    for (Fish f : fishes) {
      f.setSpeed(0);
    }
  }
}
