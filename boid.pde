class Boid {
  PVector position = new PVector(random(width), random(height));
  PVector velocity = new PVector(random(-5, 5), random(-5, 5));
  PVector acceleration = new PVector();
  float maxForce = 0.1f;
  int maxDist = 50;
  float maxSpeed = 4f;
  
  PVector align(Boid[] boids) {
    
    int tot = 0;
    PVector avg = new PVector();
    for (Boid b : boids) {
      if (b != this && position.dist(b.position) < maxDist) {
        avg.add(b.velocity);
        tot++;
      }
    }
    if (tot > 0) {
      avg.div(tot);
      avg.setMag(this.maxSpeed);
      avg.sub(this.velocity);
      avg.limit(this.maxForce);
    }
    
    return avg;
  }
  
  PVector cohesion(Boid[] boids) {
    
    int tot = 0;
    PVector avg = new PVector();
    for (Boid b : boids) {
      if (b != this && position.dist(b.position) < maxDist) {
        avg.add(b.position);
        tot++;
      }
    }
    if (tot > 0) {
      avg.div(tot);
      avg.sub(this.position);
      avg.setMag(this.maxSpeed);
      avg.sub(this.velocity);
      avg.limit(this.maxForce);
    }
    
    return avg;
  }
  
  PVector separate(Boid[] boids) {
    
    int tot = 0;
    PVector avg = new PVector();
    for (Boid b : boids) {
      float d =  position.dist(b.position);
      if (b != this && d < maxDist) {
        PVector diff = PVector.sub(this.position, b.position);
        diff.div(d * d);
        avg.add(diff);
        tot++;
      }
    }
    if (tot > 0) {
      avg.div(tot);
      avg.setMag(this.maxSpeed);
      avg.sub(this.velocity);
      avg.limit(this.maxForce);
    }
    
    return avg;
  }

  void flock(Boid[] boids) {
    this.acceleration.mult(0);
    PVector steer = align(boids);
    PVector coh = cohesion(boids);
    PVector sep = separate(boids);
    this.acceleration.add(steer);
    this.acceleration.add(coh);
    this.acceleration.add(sep);
  }
    
  void update() {
    if (this.position.x > width)
      this.position.x = 0;
    if (this.position.x < 0)
      this.position.x = width;
    if (this.position.y > height)
      this.position.y = 0;
    if (this.position.y < 0)
      this.position.y = height;
    
    this.position.add(this.velocity);
    this.velocity.add(this.acceleration);
    this.velocity.limit(this.maxSpeed);
  }
  
  void show() {
    strokeWeight(4);
    stroke(255);
    point(this.position.x, this.position.y);
  }
}
