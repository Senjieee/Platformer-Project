class FThwomp extends FGameObject {
  
  final int asleep = 1;
  final int awake = 2;
  int state;
  int frame = 0;
  
  FThwomp(float x, float y) {
    super(2, 2);
    state = asleep;
    setPosition(x, y);
    setName("thwomp");
    setRotatable(false);
    setStatic(true);
  }
  
  void act() {
    if (player.getY() > getY() + gridSize && player.getX() > getX() - gridSize && player.getX() < getX() + gridSize) {
      state = awake;
      setStatic(false);
    }
    animate();
    collide();
  }
  
  void animate() {
    if (state == awake) {
      attachImage(awakeThwomp);
    } else if (state == asleep) {
      attachImage(asleepThwomp);
    }
  }
  
  void collide() {
    if (isTouching("player")) {
      if (player.getY() > getY() + gridSize && player.getX() > getX() - gridSize && player.getX() < getX() + gridSize) {
        player.death();
      } 
    }
  }
}
