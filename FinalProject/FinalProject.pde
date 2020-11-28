//change to github

Tree[] cherryTree;

void setup() {
  size(800, 800);
  background(5);
  fill(255, 40);
  noStroke();
  smooth();

  cherryTree = new Tree[1];
  cherryTree[0] = new Tree();
}

void draw() {

  for (int j=0; j<3; j++) { 
    for (int i=0; i<cherryTree.length; i++) {
      PVector pos = cherryTree[i].position;
      float diam = cherryTree[i].diameter;
      ellipseMode(CENTER);
      ellipse(pos.x, pos.y, diam, diam); //draws tree parts
      cherryTree[i].update();
    }
  }
  

}

void mousePressed() {
  background(5);
  cherryTree = new Tree[1];
  cherryTree[0] = new Tree();
}

class Tree {


  PVector position;
  PVector velocity;
  float diameter;
  
  //Constructor of tree 
  Tree() {
    position = new PVector(width/2, height); //middle bottom of screen
    velocity = new PVector(0, -2); 
    diameter = 50; //original trunk size
  }
  
  // Constructor of branch
  Tree(Tree branch) {  
    position = branch.position.copy(); //get the location entry at a particular instance.
    velocity = branch.velocity.copy(); //get the velocity entry at a particular instance.
    float area = PI*sq(branch.diameter/2);
    float newDiam = sqrt(area/2/PI)*2;
    diameter = newDiam;
    branch.diameter = newDiam;
  }

  void update() {
    if (diameter>0.5) {
      position.add(velocity);
      PVector growth = new PVector(random(-1, 1), random(-1, 1));  // random growth direction
      growth.mult(0.1); //scale the newly grown branches by 10% 
      velocity.add(growth); //attach vector branches to each other
      velocity.normalize(); //unit vector lengths
      
      
      if (random(0, 1)<0.02) { //controls the frequency at which branches form 
        cherryTree = (Tree[]) append(cherryTree, new Tree(this)); //appends new branches to original tree from Tree class
      }
    }
  }
}
