
void ex4_motion_setup() {
}


void ex4_motion_draw() {
  ArrayList<PVector> news = tracker.diffs();
  // println("Got " + news.size());
  int maxPoints = 100;
  int skiperdie = 1;
  if (news.size() > maxPoints) {
    skiperdie = int(news.size() / maxPoints);
  }
  for (int i=0; i<news.size(); i++) {
    if (i % skiperdie == 0) {
      PVector p = news.get(i);
      
      stroke(255);
      fill(255);
      ellipse((p.x * scaleFactor), (p.y * scaleFactor), 12, 12);
    }
  }
}