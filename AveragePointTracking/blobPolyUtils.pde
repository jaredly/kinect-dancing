
BlobDetection blobs;
PImage blobImage;
PolygonBlob poly;

int blobRatio = 3;

void setupBlobPoly() {
  blobs = new BlobDetection(int(kinect.width/blobRatio), int(kinect.height/blobRatio));
  blobs.setThreshold(0.2);
  blobImage = createImage(int(kinect.width/blobRatio), int(kinect.height/blobRatio), RGB);
  poly = new PolygonBlob();
}

void updateBlobPoly() {
  // blob detection!
  tracker.updateThreshholdedImage();
  blobImage.copy(tracker.display,
    0, 0, tracker.display.width, tracker.display.height,
    0, 0, blobImage.width, blobImage.height);
  blobImage.filter(BLUR);
  blobs.computeBlobs(blobImage.pixels);

  poly = new PolygonBlob();
  poly.createPolygon(blobs, kinect.width, kinect.height);
}

void debugShowBlobPoly() {
  image(blobImage, 0, 0);
  // Show the detected polygon shape
  fill(100, 100, 255);
  beginShape();
  for (int i=0; i<poly.npoints; i++) {
    vertex(poly.xpoints[i] * scaleFactor, poly.ypoints[i] * scaleFactor);
  }
  endShape();

  // Show the blob contours
  noFill();
  strokeWeight(10);
  float xs = kinect.width * scaleFactor;
  float ys = kinect.height * scaleFactor;
  int nblobs = blobs.getBlobNb();
  for (int i=0; i<nblobs; i++) {
    stroke(255 * (i / nblobs), 255, 0, 250.0f);
    Blob blob = blobs.getBlob(i);
    int points = blob.getEdgeNb();
    for (int j=0; j<points; j++) {
      EdgeVertex va = blob.getEdgeVertexA(j);
      EdgeVertex vx = blob.getEdgeVertexB(j);
      line(va.x * xs, va.y * ys, vx.x * xs, vx.y * ys);
      //vertex(vx.x * kinect.width * scaleFactor, vx.y * kinect.width * scaleFactor);
    }
  }
}