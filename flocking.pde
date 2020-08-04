Boid flock[] = new Boid[1000];

public void settings() {
  size(800, 800);
}

void setup() {
  for (int i = 0; i < flock.length; i++) {
     flock[i] = new Boid();
  }
}

void draw() {
  background(153);
  
  for (Boid b : flock) {
    b.flock(flock);
    b.update();
    b.show();
  }
}
