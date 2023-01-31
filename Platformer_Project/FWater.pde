class FWater extends FGameObject {
  
  int frame;

  FWater(float x, float y) {
    super(1, 1);
    frame = 0;
    setPosition(x, y);
    setName("water");
    setStatic(true);
    setSensor(true);
  }

  void act() {
    animate();
    suffocate();
  }
  
  void animate() {
    if (frame >= water.length) frame = 0;
    if (frameCount % 5 == 0) {
      attachImage(water[frame]);
      frame++;
    }
  }
  
  void suffocate() {
    if ((isTouching("player") && player.getY() >= getY()) || player.getY() > getY() && player.getY() < getY() + gridSize && player.getX() > getX() - gridSize/2 && player.getX() < getX() + gridSize/2) {
      player.breath--;
    } 
    if (player.breath > 700) player.breath = 700;
  }
}
