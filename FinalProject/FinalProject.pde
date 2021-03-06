/*Kyle Su
  Final Project
  ~5 Centimeters per Second
  References thus far:
  https://www.openprocessing.org/sketch/144159 by Asher Salomon
  https://www.youtube.com/watch?v=fcdNSZ9IzJM
  https://www.youtube.com/watch?v=E1B4UoSQMFw&list=PLRqwX-V7Uu6bxNsa_3SfCPyF9Md9XvXhR&index=3
  https://www.youtube.com/watch?v=RWAcbV4X7C8
  https://www.youtube.com/watch?v=KkyIDI6rQJI&t=1s
  https://www.youtube.com/watch?v=vdgiqMkFygc&list=PLRqwX-V7Uu6Z9hI4mSgx2FlE5w8zvjmEy
  https://www.youtube.com/watch?v=krRpZFU6rSI&list=PLRqwX-V7Uu6Z9hI4mSgx2FlE5w8zvjmEy&index=4
  https://www.youtube.com/watch?v=jrTMMG0zJyI - music
  http://code.compartmental.net/minim/ Minim sound library by Damien Di Fede and Anderson Mills
  https://lh3.googleusercontent.com/proxy/fhUSglT98O3iUKGzC8eaGmUMq7y6aUVXLH6ec1sEtqTsT7_5bwzRCzDr1FF1vzVTPmSywJm2zHgvoLiGgDV1C96hy-dQumjljd1v4_netqejMOFuaBp7yXmRyeKjLq8nxwiG
  
  Use LEFT mouse button to create wind in the second scene, move the wind with MOUSE. 
  
*/

import ddf.minim.*;
Minim minim;
AudioPlayer music;

PImage wind;

Tree[] cherryTree;
PetalSystem ps;
float waterLevel = 15;
float waterHeight = 120;

void setup() {
  size(1200, 900);
  background(5,50);
  
  noStroke();
  fill(50,150,255);
  rect(0, height - 15, width, 15); //water in background
  ellipseMode(CENTER);
  stroke(255, 200);
  smooth();
  
  minim = new Minim(this);
  music = minim.loadFile("lofi.mp3");
  music.play(0); //plays music from this timeframe 

  cherryTree = new Tree[1];
  cherryTree[0] = new Tree();
  ps = new PetalSystem(new PVector(random(width), -15));
  wind = loadImage("wind.png");
  wind.resize(100,50);
  noCursor();
}

void draw() {


  growTree();
  
  if (millis() > 28000) {
  //if (millis() > 10) { //iso second scene 
    background(5,50);  
    noStroke();
    //water
    for (int i = 0; i < waterLevel; i++) {
      float fade = (1 + sin(frameCount * 0.25 + i)/8)/1.2; //use to determine frequency of color
      fill(50, 120, 150 + 150 * (waterLevel - i)/waterLevel * fade); //color changing moving effect
      rect(0, height - waterHeight + i/waterLevel * waterHeight, width, waterHeight/waterLevel); //creates waves in water
    }    
    ps.addPetals(); 
    ps.run();   
    
  }
  
}

void growTree() {
  for (int j = 0; j < .25; j++) { //loop for speed of tree growth
    for (int i = 0; i < cherryTree.length; i++) {
      PVector pos = cherryTree[i].position;
      PVector prevPos = cherryTree[i].prevPosition;
      strokeWeight(cherryTree[i].diameter); //size of line will be diameter calculated in class function
      line(prevPos.x,prevPos.y,pos.x,pos.y); //line coordinates will be positions drawn from vectors
      cherryTree[i].update();

    }
  }
  
}


class Tree {
  PVector prevPosition;
  PVector position;
  PVector velocity;
  float diameter;
  boolean blossom;
  
  Tree() {
    position = new PVector(width/2, height); //middle bottom of screen
    prevPosition = new PVector(position.x, position.y);
    velocity = new PVector(0, -1); 
    diameter = 50; //original trunk size
    blossom = false; //do not grow flower
 

  }
  
  Tree(Tree parent) { //creating new segment of tree
    position = parent.position.copy(); //get the location entry of previous branch.
    prevPosition = parent.prevPosition.copy(); 
    velocity = parent.velocity.copy();  //get the velocity entry of previous branch.
    diameter = parent.diameter * 0.67; //scale of branches and final size of tree
    blossom = parent.blossom;
    parent.diameter = diameter;
  }

  void update() { //growing the tree out
  
    if(position.x > -10 & position.x < width + 10 & position.y > - 10 & position.y < height + 10) { //set boundaries for tree
      prevPosition.set(position.x, position.y); 
      if (diameter > 0.13) { //if the tree reaches this diameter, stop growing
        PVector growth = new PVector(random(-1, 1), random(-1, 1));  // random growth direction
        velocity.normalize(); //reset units 
        growth.mult(0.24); //spread 
        velocity.mult(1.2); //bottom trunk length
        velocity.add(growth);
        //velocity.mult(random(5, 10));
        velocity.mult(random(6, 8)); //branches length
        position.add(velocity);
        if (random(0, 1) < 0.2) { //controls the frequency at which branches form 
          cherryTree = (Tree[]) append(cherryTree, new Tree(this)); //appends new branches to original tree from Tree class
        }    
      } else {
        if(!blossom) { //generate flower
          blossom = true;
          noStroke();
          //fill(255,153,204,100); //pinK!
          fill(random(245,255), random(150,160),random(200,210),100);
          ellipse(position.x,position.y,10,10); //flower
          stroke(250,200);
        }
      } 
    }
    
  }
  
}

//void keyPressed() {
//  if (key == 'r') {
//    setup();
//  }
//}
//temp reset button for testing tree visuals
//void mousePressed() {
//  background(5,50);
//  cherryTree = new Tree[1];
//  cherryTree[0] = new Tree();
//}
