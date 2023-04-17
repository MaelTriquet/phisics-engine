class Threading extends Thread {
  int start;
  int stop;

  Threading(int start_, int stop_) {
    start = start_;
    stop = stop_;
  }
  void run() {
    for (int i = start; i < stop; i++) {
      for (int j = 0; j < heightCell; j++) {
        ArrayList<Cell> neighbours = cells[i + widthCell * j].neighbours();
        for (Cell c2 : neighbours) {
          cells[i + widthCell * j].collide(c2);
        }
      }
    }
  }
}
