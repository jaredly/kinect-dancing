
void ex4_motion_setup() {
  // nothing here...
}


void ex4_motion_draw() {
  
  // ----------
  // - Config -
  // ----------
  
  color fillColor = color(255, 255, 255);
  int maxPoints = 100;
  int pointSize = 12;

  // ----------
  ArrayList<PVector> news = tracker.diffs();
  int skiperdie = 1;
  if (news.size() > maxPoints) {
    skiperdie = int(news.size() / maxPoints);
  }
  noStroke();
  fill(fillColor);
  for (int i=0; i<news.size(); i+=skiperdie) {
      PVector p = news.get(i);
      ellipse(p.x * scaleFactor, p.y * scaleFactor, pointSize, pointSize);
  }
}