class FPlayer extends FGameObject {
  
  int frame;
  int direction;
  final int L = -1;
  final int R = 1;
  
  FPlayer() {
    super();
    frame = 0;
    direction = R;
    setPosition(width/2, height/3);
    setName("player");
    setRotatable(false);
    setFillColor(red);
  }
  
  void act() {
    input();
    collisions();
    animate();
  }
  
  void animate() {
    if (frame >= action.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(action[frame]);
      if (direction == L) attachImage(reverseImage(action[frame]));
      frame++;
    }
  }
  
  void input() {
    float vx = getVelocityX();
    if (wkey) setVelocity(vx, -500);
    if (skey) setVelocity(vx, getVelocityY()+30);
    float vy = getVelocityY();
    if (vy == 0) {
      action = idle;
    }
    if (akey) {
      setVelocity(-300, vy);
      action = run;
      direction = L;
    }
    if (dkey) {
      setVelocity(300, vy);
      action = run;
      direction = R;
    }
    if (abs(vy) > 0.1) action = jump;
  }
  
  void collisions() {
    if (isTouching("spike")) {
      death();
    }
    if (isTouching("lave")) {
      death();
    }
  }
  
  void death() {
    setPosition(width/2, height/3);
  }
}
