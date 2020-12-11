
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
    velocity = new PVector(random(-1.4,1.4), random(-.8,0)); //speed at which petals fall
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

    if (location.y >= height - 100) {
      noStroke();
      //fill(255,153,204,100);
      fill(random(245,255), random(150,160),random(200,210),lifespan);
      ellipse(location.x, height - 97, diameter,diameter);
      location.y = height - 97;
    
    } 
    //wind

    if (mousePressed == true) {
      //circle(mouseX, mouseY, 50); //temp wind figure
      tint(255, 225);
      image(wind, mouseX - 50, mouseY - 25);
      if (dist(mouseX,mouseY, location.x, location.y) < 100) { //in specific radius
        float vx = constrain(location.x - mouseX, -10, 10); //change x pos
        float vy = constrain(location.y - mouseY, -10, 10); //change y pos
        location.x += vx; //add velocity to x location
        location.y += vy; //add velocity to y location 
      }
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
