ArrayList<Ball> balls = new ArrayList<Ball>();
int widthCell;
int heightCell;
int maxRadius = 13;
Cell[] cells;
int count = 0;
int fountainNb = 2;
int startI;
int stopI;
Threading[] threads = new Threading[1];
void setup() {
  size(500, 500);
  background(0);
  colorMode(HSB);
  widthCell = ((int)width) / maxRadius + 1;
  heightCell = ((int)height) / maxRadius + 1;
  cells = new Cell[widthCell * heightCell];
  for (int i = 0; i < cells.length; i++) {
    cells[i] = new Cell(i);
  }
}

void draw() {
  background(0);
  for (int i = 0; i < fountainNb; i++) {
    if (cells[i * widthCell].content.size() == 0 && !enoughBalls()) {
      balls.add(new Ball(maxRadius, new PVector(maxRadius/1.8, maxRadius/1.8+ i * (maxRadius + .1)), new PVector(mouseX, mouseY).normalize().mult(3), balls.size(), (int)map(balls.size()%1000, 0, 1000, 0, 255)));
    }
  }

  for (int i = 0; i < 8; i++) {
    collision();
  }
  for (Ball b : balls) {
    b.show();
    b.update();
  }
  count = (count+1) % 1;
  println(balls.size());
}

void collision() {
  for (Ball b : balls) {
    b.wallCollide();
  }
  updateCells();
  for (int i = 0; i < threads.length; i++) {
    threads[i] = new Threading(i * widthCell/threads.length, (i+1) * (widthCell/threads.length));
    
  }
  for (int i = 0; i < threads.length; i++) {
    threads[i].start();
  }
  try {
    for (int i = 0; i < threads.length; i++) {
      threads[i].join();
    }
  }
  catch (InterruptedException e) {
  }
}

boolean enoughBalls() {
  int sum = 0;
  for (Ball b : balls) {
    sum += b.radius/2 * b.radius/2 * 3.14;
  }
  return sum > width * height;
}

void mousePressed() {
  fountainNb++;
}

void keyPressed() {
  fountainNb = 0;
}
