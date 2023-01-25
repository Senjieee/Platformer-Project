//Johnny Geng
//1-2
//Jan 20 2023
//Platformer Project

import fisica.*;
FWorld world;

color red = #FF0000;
color blue = #1800FF;
color yellow = #FFF700;
color green = #00FF2C;
color orange = #FF8400;
color purple = #C300FF;
color black = #000000;
color white = #FFFFFF;
color brown = #996633;
color grey = #625C5C;

PImage map;
int gridSize = 32;
float zoom = 1.5;
boolean upkey, downkey, leftkey, rightkey, wkey, akey, skey, dkey, spacekey, ekey, qkey;
FPlayer player;

void setup() {
  size(600, 600);
  Fisica.init(this);

  map = loadImage("map.png");
  loadWorld(map);
  loadPlayer();
}

void loadWorld(PImage img) {
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);
  
  for (int y = 0; y < img.height; y ++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y);
      if (c == black) {
        FBox b = new FBox(gridSize, gridSize);
        b.setPosition(x*gridSize, y*gridSize);
        b.setFill(black);
        b.setStatic(true);
        world.add(b);
      }
    }
  }
}

void loadPlayer() {
  player = new FPlayer();
  world.add(player);
}

void draw() {
  background(grey);
  drawWorld();
  player.act();
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}
