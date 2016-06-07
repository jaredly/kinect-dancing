

void debugDraw() {
  
  background(100);
  // Show the threshholded image
  tracker.display();
  
  // Show the depth image on the right
  image(kinect.getDepthImage(), width - kinect.width, 0);
  
  // Draw the raw location
  PVector v1 = tracker.getPos();
  fill(50, 100, 250, 200);
  noStroke();
  ellipse(v1.x, v1.y, 20, 20);

  // Draw the lerped location
  PVector v2 = tracker.getLerpedPos();
  fill(100, 250, 50, 200);
  noStroke();
  ellipse(v2.x * scaleFactor, v2.y * scaleFactor, 20, 20);

  // Display some info
  int t = tracker.getThreshold();
  fill(0);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "- increase threshold, + decrease threshold", 10, 500);
}