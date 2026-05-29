abstract class AlingNenasStore {
  private String upgradeDescription;
  
  AlingNenasStore(String description) {
    this.upgradeDescription = description;
  }
  
  abstract void upgradeEffect();
  abstract int upgradeCost();
  
  String getUpgradeDescription() {
    return this.upgradeDescription;
  }
  
  void setUpgradeDescription(String description) {
    this.upgradeDescription = description;
  }
  
  void buyUpgrade() {
    int cost = upgradeCost();
    if (currentKita >= cost) {
      currentKita -= cost;
      upgradeEffect();
      println("Successfully bought: " + getUpgradeDescription());
    } else {
      println("Not enough Kita to buy this upgrade!");
    }
  }
}
