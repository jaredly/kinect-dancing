// Daniel Shiffman

import org.openkinect.processing.*;
import blobDetection.*;
import java.awt.Polygon;
import java.util.Collections;
import toxi.geom.*;


int current = 1;

KinectTracker tracker;
Kinect kinect;

boolean debug = true;
float scaleFactor = 3;
int dx = 0;
int dy = 0;
float ss = 1;

void setup() {
  //size(1280, 1020);
  fullScreen(1);
  smooth();
  kinect = new Kinect(this);
  scaleFactor = float(height) / float(kinect.height);
  // pref defaul: 0.3f;
  // Close: 700
  // Wall: 925
  // Far wall: 1035
  tracker = new KinectTracker(0.03f, 400);

  if (current == 1) {
    ex1_sparkler_setup();
  } else if(current == 2) {
    ex2_poly_flow_setup();
  } else if (current == 3) {
    ex3_outline_setup();
  }
}


void draw() {
  // Run the tracking analysis
  tracker.track();

  background(0);

  //image(kinect.getDepthImage(), 0, 0);
  tracker.updateThreshholdedImage();
  //image(tracker.display, 0, 0);
  if (debug) {
    debugDraw();
  }

  pushMatrix();
  scale(ss, ss);
  translate(dx, dy);

  if (current == 1) {
    ex1_sparkler_draw();
  } else if(current == 2) {
    ex2_poly_flow_draw();
  } else if (current == 3) {
    ex3_outline_draw();
  }
  
  popMatrix();

  //ex1_sparkler_draw();
  //ex2_poly_flow_draw();
  //ex2_poly_phys_draw();
}


void keyPressed() {
  int t = tracker.getThreshold();
  // -- Move the display around
  if (key == CODED) {
    if (keyCode == UP) {
      dy -= 10;
    } else if (keyCode == DOWN) {
      dy += 10;
    } else if (keyCode == LEFT) {
      dx -= 10;
    } else if (keyCode == RIGHT) {
      dx += 10;
    }
  } else if (key == 'a') {
    ss += 0.01;
  } else if (key == 's') {
    ss -= 0.01;

  // -- Change the threshold
  } else if (key == '=') {
    t += 5;
    tracker.setThreshold(t);
  } else if (key == '-') {
    t -= 5;
    tracker.setThreshold(t);
  } else if (key == 'd') {
    debug = !debug;

  // -- Switch between visualizations
  } else if (key == '1' && current != 1) {
    ex1_sparkler_setup();
    current = 1;
  } else if (key == '2' && current != 2) {
    ex2_poly_flow_setup();
    current = 2;
  } else if (key == '3' && current != 3) {
    ex3_outline_setup();
    current = 3;
  }
}