
class Petals {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float grav;
  float diameter;
  
  Petals(PVector loc) {
    lifespan = 1500; //lifespan of petal will slowly fade away based on opacity
    grav = random(0.5, 1); //gravity effect to determined weight of petal 
    diameter = grav * 8; //varying petal sizes 
    
    acceleration = new PVector (0, 0.002 * grav); 
    velocity = new PVector(random(-1.4,1.4), random(-1.2,0)); //speed at which petals fall
    location = loc.copy();
     
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 1.; //lifespan continously diminishes
  
  }
  
  void display() {
    noStroke();
    fill(random(245,255), random(150,160),random(200,210),lifespan);
    ellipse(location.x, location.y, diameter, diameter);
    if (location.y >= height - 80) {
      noStroke();
      //fill(255,153,204,100);
      fill(255, random(150,160),random(200,210),lifespan);
      ellipse(location.x, height - 57, 7,7);
    
    } 
    

       
  }

  
  boolean isDead() {
    if (lifespan <= 0) {
      return true;
    } else {
      return false;
    }
  }

}
