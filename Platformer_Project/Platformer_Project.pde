//Johnny Geng
//1-2
//Jan 20 2023
//Platformer Project

import fisica.*;
FWorld world;

color red = #FF0000;
color blue = #1A00FF;
color yellow = #FFF700;
color green = #00FF2B;
color orange = #FF8400;
color purple = #C400FF;
color black = #000000;
color white = #FFFFFF;
color brown = #996633;
color grey = #625C5C;

color treeTrunk = #9C5A3C;
color treeGreen = #19fa5c;
color border = #464646;

PImage map;
PImage grass, dirt, ice, trampoline, stone, trunk, treeCenter, treeSides, treeLeft, treeRight, spike, bridge;

PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;

PImage[] lava;

int gridSize = 32;
float zoom = 1.5;
boolean upkey, downkey, leftkey, rightkey, wkey, akey, skey, dkey, spacekey, ekey, qkey;
FPlayer player;
ArrayList<FGameObject> terrain;

void setup() {
  size(600, 600);
  //fullScreen();
  Fisica.init(this);
  terrain = new ArrayList<FGameObject>();

  loadImages();
  loadWorld(map);
  loadPlayer();
}

void loadImages() {
  map = loadImage("map.png");
  grass = loadImage("dirt_n.png");
  dirt = loadImage("dirt_center.png");
  ice = loadImage("blueBlock.png");
  stone = loadImage("brick.png");
  trampoline = loadImage("trampoline");
  trunk = loadImage("tree_trunk.png");
  treeCenter = loadImage("tree_intersect.png");
  treeSides = loadImage("treetop_center.png");
  treeLeft = loadImage("treetop_w.png");
  treeRight = loadImage("treetop_e.png");
  spike = loadImage("spike.png");
  bridge = loadImage("bridge_center.png");
  
  lava = new PImage[6];
  lava[0] = loadImage("lava0.png");
  lava[1] = loadImage("lava1.png");
  lava[2] = loadImage("lava2.png");
  lava[3] = loadImage("lava3.png");
  lava[4] = loadImage("lava4.png");
  lava[5] = loadImage("lava5.png");
  
  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");
  
  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");
  
  run = new PImage[3];
  run[0] = loadImage("runright0.png");
  run[1] = loadImage("runright1.png");
  run[2] = loadImage("runright2.png");
  
  action = idle;
}

void loadWorld(PImage img) {
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);
  
  for (int y = 0; y < img.height; y ++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y); //current pixel
      color s = img.get(x, y+1); //below current pixel
      color w = img.get(x-1, y); //left current pixel
      color e = img.get(x+1, y); //right current pixel
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      if (c == black) {
        b.attachImage(stone);
        b.setFriction(4);
        b.setName("stone");
        world.add(b);
      }
      else if (c == green) {
        b.attachImage(grass);
        b.setFriction(4);
        b.setName("grass");
        world.add(b);
      }
      else if (c == brown) {
        b.attachImage(dirt);
        b.setFriction(4);
        b.setName("dirt");
        world.add(b);
      }
      else if (c == blue) {
        b.setFriction(0);
        b.attachImage(ice);
        b.setName("ice");
        world.add(b);
      }
      else if (c == treeTrunk) {
        b.attachImage(trunk);
        b.setFriction(4);
        b.setName("treetrunk");
        world.add(b);
      }
      else if (c == treeGreen && s == treeTrunk) {
        b.attachImage(treeCenter);
        b.setFriction(4);
        b.setName("treetop");
        world.add(b);
      }
      else if (c == treeGreen && w == treeGreen && e == treeGreen) {
        b.attachImage(treeSides);
        b.setFriction(4);
        b.setName("treetop");
        world.add(b);
      }
      else if (c == treeGreen && w != treeGreen) {
        b.attachImage(treeLeft);
        b.setFriction(4);
        b.setName("treetop");
        world.add(b);
      }
      else  if (c == treeGreen && e != treeGreen) {
        b.attachImage(treeRight);
        b.setFriction(4);
        b.setName("treetop");
        world.add(b);
      }
      else if (c == purple) {
        b.attachImage(spike);
        b.setFriction(4);
        b.setName("spike");
        world.add(b);
      }
      else if (c == border) {
        world.add(b);
      }
      else if (c == red) {
        b.attachImage(trampoline);
        b.setFriction(4);
        b.setRestitution(3);
        b.setName("trampoline");
        world.add(b);
      }
      else if (c == yellow) {
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
      }
      else if (c == orange) {
        FLava lv = new FLava(x*gridSize, y*gridSize);
        terrain.add(lv);
        world.add(lv);
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
  actWorld();
}

void actWorld() {
  player.act();
  for(int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}
