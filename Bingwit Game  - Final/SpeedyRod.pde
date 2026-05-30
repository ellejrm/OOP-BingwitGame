class SpeedyRod extends AlingNenasStore {
  boolean speedyRod = false;

  SpeedyRod() {
    super("Speedy Rod: Upgrades lines to cast and swing significantly faster!");
  }

  @Override
  int upgradeCost() {
    return 150; 
  }

  @Override
  void upgradeEffect() {
    this.speedyRod = true;
   
    extendSpeed = 5;
    swingSpeed = 0.04;
  }
}
