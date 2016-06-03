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
boolean debug = true;
int scaleFactor = 3;
int reScale = 2;

void setup() {
  size(1280, 1040);
  smooth();
  // pref defaul: 0.3f;
  // Close: 700
  // Wall: 925
  tracker = new KinectTracker(0.03f, 925);
  blobs = new BlobDetection(kinect.width/scaleFactor, kinect.height/scaleFactor);
  blobs.setThreshold(0.2);
  blobImage = new PImage(kinect.width/scaleFactor, kinect.height/scaleFactor, RGB);
  poly = new PolygonBlob();

  ex2_poly_flow_setup();
}


void draw() {
  // Run the tracking analysis
  tracker.track();

  updateBlobPoly();

  background(0);
  //image(tracker.display, 0, 0);
  if (debug) {
    image(blobImage, 0, 0);
    fill(0, 255, 0, 250.0f);
    beginShape();
    for (int i=0; i<poly.npoints; i++) {
      vertex(poly.xpoints[i], poly.ypoints[i]);
    }
    endShape(CLOSE);
  }

  if (debug) {
    //debugDraw();
  }

  //ex1_sparkler_draw();
  ex2_poly_flow_draw();
}

void updateBlobPoly() {
  // blob detection!
  tracker.updateThreshholdedImage();
  blobImage.copy(tracker.display,
    0, 0, tracker.display.width, tracker.display.height,
    0, 0, blobImage.width, blobImage.height);
  blobImage.filter(BLUR);
  blobs.computeBlobs(blobImage.pixels);
  poly.reset();
  poly.createPolygon(blobs, kinect.width, kinect.height);
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