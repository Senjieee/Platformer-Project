class FPlayer extends FBox {
  
  FPlayer() {
    super(gridSize, gridSize);
    setPosition(300, 200);
    setFillColor(red);
  }
  
  void act() {
    float vx = getVelocityX();
    if (wkey) setVelocity(vx, -500);
    if (skey) setVelocity(vx, getVelocityY()+30);
    float vy = getVelocityY();
    if (akey) setVelocity(-300, vy);
    if (dkey) setVelocity(300, vy);
  }
}
