
class PetalSystem {
  ArrayList<Petals> petalsystem;
  PVector start;
  
  PetalSystem(PVector location) {
    start = location.copy();
    petalsystem = new ArrayList<Petals>();
  }
  
  void addPetals() {
    petalsystem.add(new Petals(new PVector(random(width), -5)));


  }

  void run() {
    for (int i = petalsystem.size()-1; i >= 0; i--) {
      Petals petals = petalsystem.get(i);
      petals.update();
      petals.display();
      
      
      if (petals.isDead()) {
        petalsystem.remove(i);
      }    
    }
  }
  
}
