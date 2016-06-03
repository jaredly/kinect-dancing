
// ToxiclibsSupport for displaying polygons
ToxiclibsSupport gfx;
// declare custom PolygonBlob object (see class for more info)
PolygonBlob2 poly2;

color bgColor2, blobColor;

// the main PBox2D object in which all the physics-based stuff is happening
Box2DProcessing box2d;
// list to hold all the custom shapes (circles, polygons)
ArrayList<CustomShape> polygons = new ArrayList();


// three color palettes (artifact from me storing many interesting color palettes as strings in an external data file ;-)
String[] palettes2 = {
  "-1117720,-13683658,-8410437,-9998215,-1849945,-5517090,-4250587,-14178341,-5804972,-3498634", 
  "-67879,-9633503,-8858441,-144382,-4996094,-16604779,-588031", 
  "-1978728,-724510,-15131349,-13932461,-4741770,-9232823,-3195858,-8989771,-2850983,-10314372"
};
color[] colorPalette;


// sets the colors every nth frame
void setRandomColors2(int nthFrame) {
  if (frameCount % nthFrame == 0) {
    // turn a palette into a series of strings
    String[] paletteStrings = split(palettes[int(random(palettes.length))], ",");
    // turn strings into colors
    colorPalette = new color[paletteStrings.length];
    for (int i=0; i<paletteStrings.length; i++) {
      colorPalette[i] = int(paletteStrings[i]);
    }
    // set background color to first color from palette
    bgColor = colorPalette[0];
    // set blob color to second color from palette
    blobColor = colorPalette[1];
    // set all shape colors randomly
    for (CustomShape cs : polygons) { 
      cs.col = getRandomColor();
    }
  }
}



void ex2_poly_phys_setup() {
  // initialize ToxiclibsSupport object
  gfx = new ToxiclibsSupport(this);
  // setup box2d, create world, set gravity
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -20);
  // set random colors (background, blob)
  setRandomColors2(1);
}

void ex2_poly_phys_draw() {

  // initialize a new polygon
  poly2 = new PolygonBlob2();
  // create the polygon from the blobs (custom functionality, see class)
  poly2.createPolygon(blobs, kinect.width, kinect.height);

  // create the box2d body from the polygon
  poly2.createBody();
  // update and draw everything (see method)
  updateAndDrawBox2D();
  // destroy the person's body (important!)
  poly2.destroyBody();
  // set the colors randomly every 240th frame
  setRandomColors2(240);
}


float time = 0;
void updateAndDrawBox2D() {
  // if frameRate is sufficient, add a polygon and a circle with a random radius
  time++;
  if (time % 20 == 0) {
    if (frameRate > 29) {
      polygons.add(new CustomShape(kinect.width/2, -50, -1, poly2));
      polygons.add(new CustomShape(kinect.width/2, -50, random(2.5, 20), poly2));
    }
  }
  // take one step in the box2d physics world
  box2d.step();

  // center and reScale from Kinect to custom dimensions
  translate(0, (height-kinect.height*reScale)/2);
  scale(reScale);

  // display the person's polygon  
  noStroke();
  fill(blobColor);
  gfx.polygon2D(poly2);

  // display all the shapes (circles, polygons)
  // go backwards to allow removal of shapes
  for (int i=polygons.size()-1; i>=0; i--) {
    CustomShape cs = polygons.get(i);
    // if the shape is off-screen remove it (see class for more info)
    if (cs.done()) {
      polygons.remove(i);
      // otherwise update (keep shape outside person) and display (circle or polygon)
    } else {
      cs.update();
      cs.display();
    }
  }
}