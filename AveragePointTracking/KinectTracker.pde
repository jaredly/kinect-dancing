// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

class KinectTracker {

  // Depth threshold
  int threshold;
  float lerpAmount;

  // Raw location
  PVector loc;

  // Interpolated location
  PVector lerpedLoc;

  // Depth data
  int[] depth;
  
  // What we'll show the user
  PImage display;
  int[] nows;
  int[] prev;
  boolean loaded = false;
  
  KinectTracker(float lerpAmount, int threshhold) {
    this.threshold = threshhold;
    this.lerpAmount = lerpAmount;
    // This is an awkard use of a global variable here
    // But doing it this way for simplicity
    kinect.initDepth();
    //kinect.enableMirror(true);
    // Make a blank image
    display = createImage(kinect.width, kinect.height, RGB);
    // Set up the vectors
    loc = new PVector(0, 0);
    lerpedLoc = new PVector(0, 0);
  }

  ArrayList<PVector> diffs() {
    nows = kinect.getRawDepth();
    ArrayList<PVector> result = new ArrayList();
    if (!loaded) {
      prev = nows;
      loaded = true;
      return result;
    }
    
    for (int x = 0; x < kinect.width; x++) {
      for (int y = 0; y < kinect.height; y++) {
        int offset =  x + y*kinect.width;
        int rawDepth = nows[offset];
        int oldDepth = prev[offset];
        if ((rawDepth < threshold) != (oldDepth < threshold)) {
          result.add(new PVector(x, y));
        }
      }
    }
    prev = nows;
    return result;
  }

  void track() {
    // Get the raw depth as array of integers
    depth = kinect.getRawDepth();

    // Being overly cautious here
    if (depth == null) return;

    float sumX = 0;
    float sumY = 0;
    float count = 0;

    for (int x = 0; x < kinect.width; x++) {
      for (int y = 0; y < kinect.height; y++) {
        
        int offset =  x + y*kinect.width;
        // Grabbing the raw depth
        int rawDepth = depth[offset];

        // Testing against threshold
        if (rawDepth < threshold) {
          sumX += x;
          sumY += y;
          count++;
        }
      }
    }
    // As long as we found something
    if (count != 0) {
      loc = new PVector(sumX/count, sumY/count);
    }

    // Interpolating the location, doing it arbitrarily for now
    lerpedLoc.x = PApplet.lerp(lerpedLoc.x, loc.x, this.lerpAmount);
    lerpedLoc.y = PApplet.lerp(lerpedLoc.y, loc.y, this.lerpAmount);
  }

  PVector getLerpedPos() {
    return lerpedLoc;
  }

  PVector getPos() {
    return loc;
  }

  void getThreshholdedImage(PImage target) {
    PImage img = kinect.getDepthImage();

    // Being overly cautious here
    if (depth == null || img == null) return;

    // Going to rewrite the depth image to show which pixels are in threshold
    // A lot of this is redundant, but this is just for demonstration purposes
    target.loadPixels();
    for (int x = 0; x < kinect.width; x++) {
      for (int y = 0; y < kinect.height; y++) {

        int offset = x + y * kinect.width;
        // Raw depth
        int rawDepth = depth[offset];
        int pix = x + y * target.width;
        if (rawDepth < threshold) {
          // A red color instead
          target.pixels[pix] = color(150, 50, 50);
        } else {
          target.pixels[pix] = color(0,0,0);//img.pixels[offset];
        }
      }
    }
    target.updatePixels();
  }
  
  void updateThreshholdedImage() {
    getThreshholdedImage(display);
  }

  void display() {
    //updateThreshholdedImage();
    // Draw the image
    image(display, 0, 0);
  }

  int getThreshold() {
    return threshold;
  }

  void setThreshold(int t) {
    threshold =  t;
  }
}