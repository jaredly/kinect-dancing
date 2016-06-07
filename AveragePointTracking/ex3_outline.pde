
void ex3_outline_setup() {
  setupBlobPoly();
}

void ex3_outline_draw() {
  
  // ----------
  // - Config -
  // ----------
  
  color fillColor = color(255, 255, 255);
  int maxPoints = 100;
  int pointSize = 12;
  
  
  // ----------
  updateBlobPoly();
  
  if (debug) {
    debugShowBlobPoly();
  }

  int points = poly.xpoints.length;
  int skiperdie = 1;
  if (points > maxPoints) {
    skiperdie = int(points / maxPoints);
  }

  noStroke();
  fill(fillColor);
  for (int i=0; i<points; i+=skiperdie) {
    ellipse(poly.xpoints[i] * scaleFactor, poly.ypoints[i] * scaleFactor, pointSize, pointSize);
  }
}