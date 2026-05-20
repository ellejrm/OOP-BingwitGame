abstract class SeaObject {
  int id;
  float xLoc;
  float yLoc;
  int size;
  int value;
  boolean isCaught;

  //methods
  abstract void display();
  abstract void applyKita();


  void setID(int id) {
    this.id = id;
  }

  int getID() {
    return id;
  }

  void setXLoc(float xLoc) {
    this.xLoc = xLoc;
  }

  float getXLoc() {
    return xLoc;
  }

  void setYLoc(float yLoc) {
    this.yLoc = yLoc;
  }

  float getYLoc() {
    return yLoc;
  }

  void setSize(int size) {
    this.size = size;
  }

  int getSize() {
    return size;
  }

  void setValue(int value) {
    this.value = value;
  }

  int getValue() {
    return value;
  }
}
