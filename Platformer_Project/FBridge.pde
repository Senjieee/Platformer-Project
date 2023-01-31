class FBridge extends FGameObject {

  FBridge(float x, float y) {
    super(1, 1);
    setPosition(x, y);
    setName("bridge");
    attachImage(bridge);
    setStatic(true);
  }

  void act() {
    if (isTouching("player")) {
      setStatic(false);
      setSensor(true);
    }
  }
}
