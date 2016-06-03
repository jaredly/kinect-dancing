
ParticleSystem ps;

void ex1_sparkler_setup() {
  ps = new ParticleSystem(new PVector(width/2, 50), 50.0);

}

void ex1_sparkler_draw() {
  
  fill(0,2.0f);
  rect(0,0,width,height);
  PVector lerpedPos = tracker.getLerpedPos();
  for (int i=0; i<10; i++) {
    ps.origin = lerpedPos;
    ps.addParticle();
  }
  ps.run();
}