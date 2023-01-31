class FPlayer extends FGameObject {
  
  int frame;
  int direction;
  int lives;
  float breath;
  
  FPlayer() {
    super(1, 1);
    frame = 0;
    direction = R;
    lives = 3;
    breath = 700;
    setPosition(width/2 + 100, height/2 + 400);
    setName("player");
    setRotatable(false);
    setFillColor(red);
  }
  
  void act() {
    input();
    collisions();
    animate();
    showLives();
    if (breath < 700) showBreath();
    breath++;
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
    if (isTouching("goomba") || isTouching("thwomp") || isTouching("stone") || isTouching("grass") || isTouching("dirt") || isTouching("ice") || isTouching("treetop") || isTouching("spike") || isTouching("trampoline") || isTouching("bridge") || isTouching("wall")) {
      if (wkey) setVelocity(vx, -500);
    }
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
    if (isTouching("lava")) {
      death();
    }
    if (isTouching("water")) {
      float vx = getVelocityX();
      float vy = getVelocityY();
      setVelocity(vx, vy/1.5);
    }
    if (breath <= 0) death();
  }
  
  void death() {
    setPosition(width/2 + 100, height/2 + 400);
    lives--;
    breath = 700;
  }
  
  void showLives() {
    fill(black);
    textSize(45);
    text("x" + lives, 20, 555);
    if (lives > 2) lifePoints(160, 500);
    if (lives > 1) lifePoints(120, 500);
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
  
  void showBreath() {
    if (breath > 0) air(25, 490);
    if (breath > 100) air(49, 490);
    if (breath > 200) air(73, 490);
    if (breath > 300) air(97, 490);
    if (breath > 400) air(121, 490);
    if (breath > 500) air(145, 490);
    if (breath > 600) air(169, 490);
  }
  
  void air(float x, float y) {
    fill(air1);
    rect(x, y, 9, 3);
    rect(x + 9, y + 3, 3, 3);
    rect(x - 3, y + 3, 3, 3);
    rect(x - 6, y + 6, 3, 9);
    rect(x - 3, y + 15, 3, 3);
    fill(air2);
    rect(x + 12, y + 6, 3, 9);
    rect(x + 9, y + 15, 3, 3);
    rect(x, y + 18, 9, 3);
    fill(white);
    rect(x, y + 6, 6, 3);
    rect(x, y + 9, 3, 3);
  }
}
