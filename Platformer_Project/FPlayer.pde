class FPlayer extends FBox {
  
  FPlayer() {
    super(gridSize, gridSize);
    setPosition(300, 200);
    setFillColor(red);
  }
  
  void act() {
    float vy = getVelocityY();
    if (akey) setVelocity(-300, vy);
    if (dkey) setVelocity(300, vy);
  }
}
