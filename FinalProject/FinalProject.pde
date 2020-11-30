/*Kyle Su
  Final Project
  ~5 Centimeters per Second
  References thus far:
  https://www.youtube.com/watch?v=fcdNSZ9IzJM
  https://www.youtube.com/watch?v=E1B4UoSQMFw&list=PLRqwX-V7Uu6bxNsa_3SfCPyF9Md9XvXhR&index=3
  https://www.youtube.com/watch?v=RWAcbV4X7C8
  https://www.openprocessing.org/sketch/144159
  https://www.youtube.com/watch?v=KkyIDI6rQJI&t=1s


*/

class Tree {
  PVector prevPosition;
  PVector position;
  PVector velocity;
  float diameter;
  boolean blossom;
  
  Tree() {
    position = new PVector(width/2, height); //middle bottom of screen
    prevPosition = new PVector(position.x, position.y);
    velocity = new PVector(0, -10); 
    diameter = 50; //original trunk size
    blossom = false; //do not grow flower
  }
  
  Tree(Tree parent) { //creating new segment of tree
    position = parent.position.copy(); //get the location entry of previous branch.
    prevPosition = parent.prevPosition.copy(); 
    velocity = parent.velocity.copy();  //get the velocity entry of previous branch.
    diameter = parent.diameter * 0.65; //scaled down branches
    blossom = parent.blossom;
    parent.diameter = diameter;
  }

  void update() { //growing the tree out
  
    if(position.x > -10 & position.x < width + 10 & position.y > - 10 & position.y < height + 10) {
      prevPosition.set(position.x, position.y);
      if (diameter > 0.13) { //if the tree reaches this diameter, stop growing
        PVector growth = new PVector(random(-1, 1), random(-1, 1));  // random growth direction
        velocity.normalize();
        growth.mult(0.3); //spread 
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
          fill(255,153,204,100);
          ellipse(position.x,position.y,10,10); //temp flower, change to a class flower and set position x,y to this)
          stroke(250,200);
        }
        
      }
    
    }
    
  }
  
}

Tree[] cherryTree;

void setup() {
  size(1000, 900);
  background(5,50);
  ellipseMode(CENTER);
  stroke(255, 200);
  smooth();

  cherryTree = new Tree[1];
  cherryTree[0] = new Tree();
  
}

void draw() {

  for (int j = 0; j < 1; j++) { 
    for (int i = 0; i < cherryTree.length; i++) {
      PVector pos = cherryTree[i].position;
      PVector prevPos = cherryTree[i].prevPosition;
      strokeWeight(cherryTree[i].diameter);
      line(prevPos.x,prevPos.y,pos.x,pos.y);
      cherryTree[i].update();
    }
  }
  
}

void mousePressed() {
  background(5,50);
  cherryTree = new Tree[1];
  cherryTree[0] = new Tree();
}
