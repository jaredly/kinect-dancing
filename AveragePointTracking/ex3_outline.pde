
void ex3_outline_setup() {
  setupBlobPoly();
}

void ex3_outline_draw() {
  updateBlobPoly();
  
  if (debug) {
    debugShowBlobPoly();
  }

  /*
  int points = poly.xpoints.length;
  int maxPoints = 100;
  int skiperdie = 1;
  if (points > maxPoints) {
    skiperdie = int(points / maxPoints);
  }
  for (int i=0; i<points; i++) {
    if (i % skiperdie == 0) {
      stroke(255);
      fill(255);
      ellipse(poly.xpoints[i] * scaleFactor, poly.ypoints[i] * scaleFactor, 12, 12);
    }
  }
  */
}