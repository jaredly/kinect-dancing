
ParticleSystem ps;

void ex1_sparkler_setup() {
  ps = new ParticleSystem(new PVector(width/2, 50), 50.0);

}

int numberOfSparklers = 5;


float r = 0;
void ex1_sparkler_draw() {
  //r += 0.05;
  
  PVector lerpedPos = tracker.getLerpedPos();
  ps.origin = new PVector(lerpedPos.x * scaleFactor, lerpedPos.y * scaleFactor);
  for (int i=0; i<10; i++) {
    ps.addParticle();
  }
  //ps.run();
  ps.update();
  float dist = 100;
  for (int i=0; i<numberOfSparklers; i++) {
    float rot = PI * 2 / 5 * i + r;
    float x = cos(rot) * dist;
    float y = sin(rot) * dist;
    ps.display(x, y);
  }
}