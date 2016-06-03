// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import blobDetection.*;
import java.awt.Polygon;
import java.util.Collections;


BlobDetection blobs;
PImage blobImage;
PolygonBlob poly;

// The kinect stuff is happening in another class
KinectTracker tracker;
Kinect kinect;
ParticleSystem ps;
boolean debug = true;
int scaleFactor = 3;

void setup() {
  size(640, 520);
  smooth();
  kinect = new Kinect(this);
  // pref defaul: 0.3f;
  tracker = new KinectTracker(0.03f, 700);
  ps = new ParticleSystem(new PVector(width/2, 50), 50.0);
  blobs = new BlobDetection(kinect.width/scaleFactor, kinect.height/scaleFactor);
  blobs.setThreshold(0.2);
  blobImage = new PImage(kinect.width/scaleFactor, kinect.height/scaleFactor, RGB);
  poly = new PolygonBlob();
}

void draw() {
  // Run the tracking analysis
  tracker.track();
  
  // blob detection!
  tracker.updateThreshholdedImage();
  blobImage.copy(tracker.display, 0, 0, tracker.display.width, tracker.display.height,
  0, 0, blobImage.width, blobImage.height);
  blobImage.filter(BLUR);
  blobs.computeBlobs(blobImage.pixels);
  poly.reset();
  poly.createPolygon(blobs, kinect.width, kinect.height);
  
  background(0);
  fill(255, 0, 0);
  beginShape();
  for (int i=0; i<poly.npoints; i++) {
    vertex(poly.xpoints[i], poly.ypoints[i]);
  }
  endShape(CLOSE);
  
  if (debug) {
    //background(255);
    //debugDraw();
  } else {
    //fill(0,2.0f);
    //rect(0,0,width,height);
  }
  PVector lerpedPos = tracker.getLerpedPos();
  for (int i=0; i<10; i++) {
    //PVector off = new PVector(random(-1.0, 1.0) * 15, random(-1.0, 1.0) * 15);
    ps.origin = lerpedPos;//.copy().add(off);
    ps.addParticle();
  }
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