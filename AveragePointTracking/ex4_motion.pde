
void ex4_motion_setup() {
}

void ex4_motion_draw() {
  ArrayList<PVector> news = tracker.diffs();
  println("Got " + news.size());
  for (int i=0; i<news.size(); i++) {
    if (i % 5 == 0) {
      PVector p = news.get(i);
      
      stroke(255);
      fill(255);
      ellipse((p.x * scaleFactor), (p.y * scaleFactor), 12, 12);
    }
  }
}