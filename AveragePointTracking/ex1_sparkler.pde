
ParticleSystem ps;


// ----------

void ex1_sparkler_setup() {
  ps = new ParticleSystem(new PVector(width/2, 50), 50.0);
}

void ex1_sparkler_draw() {
  // ----------
  // - Config -
  // ----------
  
  int numberOfSparklers = 5;
  int radiusFromCenter = 100;
  int newParticlesPerTick = 10;
  color fillColor = color(255, 255, 255);
  
  PVector lerpedPos = tracker.getLerpedPos();
  ps.origin = new PVector(lerpedPos.x * scaleFactor, lerpedPos.y * scaleFactor);
  for (int i=0; i<newParticlesPerTick; i++) {
    ps.addParticle();
  }
  ps.update();
  for (int i=0; i<numberOfSparklers; i++) {
    float rot = PI * 2 / numberOfSparklers * i;
    float x = cos(rot) * radiusFromCenter;
    float y = sin(rot) * radiusFromCenter;
    ps.display(x, y, fillColor);
  }
}