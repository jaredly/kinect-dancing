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
//import toxi.geom.*;
//import toxi.physics2d.*;
import toxi.geom.*;
import toxi.processing.*;
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*; // jbox2d
import org.jbox2d.common.*; // jbox2d
import org.jbox2d.dynamics.*; // jbox2d

BlobDetection blobs;
PImage blobImage;
PolygonBlob poly;

// The kinect stuff is happening in another class
KinectTracker tracker;
Kinect kinect;
boolean debug = true;
float scaleFactor = 3;
float reScale = 1;

void setup() {
  //size(1280, 1020);
  fullScreen(1);
  smooth();
  kinect = new Kinect(this);
  //kinect.enableMirror(true);
  //reScale = height / kinect.height;
  scaleFactor = float(height) / float(kinect.height);
  // pref defaul: 0.3f;
  // Close: 700
  // Wall: 925
  tracker = new KinectTracker(0.03f, 925);
  /*
  blobs = new BlobDetection(kinect.width/scaleFactor, kinect.height/scaleFactor);
  blobs.setThreshold(0.2);
  blobImage = new PImage(kinect.width/scaleFactor, kinect.height/scaleFactor, RGB);
  poly = new PolygonBlob();
  */

  ex1_sparkler_setup();
  //ex2_poly_flow_setup();
  //ex2_poly_phys_setup();
}


void draw() {
  // Run the tracking analysis
  tracker.track();

  background(0);
  //pushMatrix();
  //scale(-1, 1);
  //translate(-width, 0);

  //updateBlobPoly();


  //image(kinect.getDepthImage(), 0, 0);
  tracker.updateThreshholdedImage();
  //image(tracker.display, 0, 0);
  if (debug) {
    debugDraw();
  }

  ex1_sparkler_draw();
  //ex2_poly_flow_draw();
  //ex2_poly_phys_draw();
  //popMatrix();
}

void updateBlobPoly() {
  // blob detection!
  tracker.updateThreshholdedImage();
  blobImage.copy(tracker.display,
    0, 0, tracker.display.width, tracker.display.height,
    0, 0, blobImage.width, blobImage.height);
  blobImage.filter(BLUR);
  blobs.computeBlobs(blobImage.pixels);
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