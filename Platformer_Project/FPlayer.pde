class FPlayer extends FGameObject {
  
  int frame;
  int direction;
  int lives;
  
  FPlayer() {
    super();
    frame = 0;
    direction = R;
    lives = 3;
    setPosition(width/2, height/3);
    setName("player");
    setRotatable(false);
    setFillColor(red);
  }
  
  void act() {
    input();
    collisions();
    animate();
    showLives();
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
    //if (isTouching("stone" || "grass" || "dirt" || "ice" || "treetop" || "spike" || "trampoline" || "bridge")) {
      if (wkey) setVelocity(vx, -500);
    //}
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
    lives--;
  }
  
  void showLives() {
    fill(black);
    textSize(45);
    text("x" + lives, 20, 555);
    if (lives > 2) lifePoints(165, 500);
    if (lives > 1) lifePoints(125, 500);
    if (lives > 0) lifePoints(80, 500);
  }
  
  void lifePoints(float x, float y) {
    fill(red);
    noStroke();
    rect(x, y + 25, 10, 5);
    rect(x + 15, y + 25, 10, 5);
    rect(x + 5, y + 30, 25, 5);
    rect(x - 5, y + 30, 5, 10);
    rect(x, y + 35, 25, 10);
    rect(x + 5, y + 45, 15, 5);
    rect(x + 10, y + 50, 5, 5);
    rect(x + 25, y + 35, 5, 5);
    fill(white);
    rect(x, y + 30, 5, 5);
  }
}
