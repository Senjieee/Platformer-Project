class FLava extends FGameObject {
  
  int frame;

  FLava(float x, float y) {
    super(1, 1);
    frame = 0;
    setPosition(x, y);
    setName("lava");
    setStatic(true);
    setSensor(true);
  }

  void act() {
    animate();
  }
  
  void animate() {
    if (frame >= lava.length) frame = 0;
    if (frameCount % 5 == 0) {
      attachImage(lava[frame]);
      frame++;
    }
  }
}
