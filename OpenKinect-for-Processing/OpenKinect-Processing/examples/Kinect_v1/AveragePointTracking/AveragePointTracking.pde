// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

// The kinect stuff is happening in another class
KinectTracker tracker;
Kinect kinect;
ParticleSystem ps;
boolean debug = true;

void setup() {
  size(640, 520);
  smooth();
  kinect = new Kinect(this);
  // pref defaul: 0.3f;
  tracker = new KinectTracker(0.03f, 700);
  ps = new ParticleSystem(new PVector(width/2, 50), 50.0);
}

void draw() {
  // Run the tracking analysis
  tracker.track();
  if (debug) {
    background(255);
    debugDraw();
  } else {
    //background(0);
    fill(0,2.0f);
    rect(0,0,width,height);
    //background(255,1.0f);
  }

  ps.origin = tracker.getLerpedPos();
  ps.addParticle();
  ps.run();
}

// Adjust the threshold with key presses
void keyPressed() {
  int t = tracker.getThreshold();
  if (key == CODED) {
    if (keyCode == UP) {
      t+=5;
      tracker.setThreshold(t);
    } else if (keyCode == DOWN) {
      t-=5;
      tracker.setThreshold(t);
    }
  } else if (key == 'd') {
    //background(0);
    debug = !debug;
  }
}