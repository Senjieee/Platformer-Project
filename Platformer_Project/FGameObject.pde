class FGameObject extends FBox {
  
  final int L = -1;
  final int R = 1;
  
  FGameObject(int w, int h) {
    super(gridSize*w, gridSize*h);
  }
  
  void act() {
  }
  
  boolean isTouching(String n) {
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i++) {
      FContact fc = contacts.get(i);
      if (fc.contains(n)) {
        return true;
      }
    }
    return false;
  }
}
