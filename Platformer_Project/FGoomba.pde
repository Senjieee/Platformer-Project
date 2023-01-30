class FGoomba extends FGameObject {
  
  int frame = 0;
  int direction = R;
  int speed = 50;
  int lives;
  
  FGoomba(float x, float y) {
    super();
    setPosition(x, y);
    lives = 1;
    setName("goomba");
    setRotatable(false);
  }
  
  void act() {
    animate();
    collide();
    move();
  }
  
  void animate() {
    if (frame >= goomba.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(goomba[frame]);
      if (direction == L) attachImage(reverseImage(goomba[frame]));
      frame++;
    }
  }
  
  void collide() {
    if (isTouching("wall")) {
      direction *= -1;
      setPosition(getX()+direction, getY());
    }
    
    if (isTouching("player")) {
      if (player.getY() < getY()-gridSize/2 && player.getX() > getX() - gridSize && player.getX() < getX() + gridSize) {
        death();
        player.setVelocity(player.getVelocityX(), -300);
      } else {
        player.death();
      }
    }
  }
  
  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }
  
  void death() {
    world.remove(this);
    enemies.remove(this);
  }
}
