class Ball {
  int radius;
  PVector acc;
  PVector vel;
  PVector pos;
  PVector prev_pos;
  color col;
  float mass = 1;
  boolean bouncy = false;
  int index;

  Ball(int radius_, PVector pos_, PVector vel_, int index_, int col_) {
    radius = radius_;
    vel = vel_;
    pos = pos_;
    prev_pos = pos.copy().sub(vel_);
    acc = new PVector(0, .1); //gravity
    index = index_;
    col = color(col_, 255, 255);
  }

  void show() {
    fill(col);
    circle(pos.x, pos.y, radius);
  }
  
  void update() {
    vel = pos.copy().sub(prev_pos);
    prev_pos = pos.copy();
    vel.add(acc);
    pos.add(vel);
  }

  void wallCollide() {
    if (pos.x < radius/2) {
      pos.x = radius/2;
      if (bouncy) {
        vel.x *= -.5;
      } else {
        vel.x *= -.1;
      }
    }
    if (pos.x > width - radius/2) {
      pos.x = width - radius/2;
      if (bouncy) {
        vel.x *= -.5;
      } else {
        vel.x *= -.1;
      }
    }
    if (pos.y < radius/2) {
      pos.y = radius/2;
      if (bouncy) {
        vel.y *= -.5;
      } else {
        vel.y *= -.1;
      }
    }
    if (pos.y > height - radius/2) {
      pos.y = height - radius/2;
      if (bouncy) {
        vel.y *= -.5;
      } else {
        vel.y *= -.1;
      }
    }
  }

  void collide(Ball other) {

    PVector distPos = PVector.sub(other.pos, pos);

    float dist = distPos.mag();

    float minDist = radius/2 + other.radius/2;

    if (dist <= minDist) {
      float overlap = (minDist-dist)/2;
      PVector d = distPos.copy();
      float sumVel = vel.mag() + other.vel.mag();
      float responseCoef = map(min(sumVel * sumVel, 60), 0, 60, .9, .05); 
      PVector correction = d.normalize().mult(overlap * responseCoef);
      other.pos.add(correction);
      pos.sub(correction);
    }
  }
}
