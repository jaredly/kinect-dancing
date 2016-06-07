
// background color
color bgColor;
// three color palettes (artifact from me storing many interesting color palettes as strings in an external data file ;-)
String[] palettes = {
  "-1117720,-13683658,-8410437,-9998215,-1849945,-5517090,-4250587,-14178341,-5804972,-3498634", 
  "-67879,-9633503,-8858441,-144382,-4996094,-16604779,-588031", 
  "-16711663,-13888933,-9029017,-5213092,-1787063,-11375744,-2167516,-15713402,-5389468,-2064585"
};

NoisyParticle[] flow = new NoisyParticle[2250];

void ex2_poly_flow_setup() {
  setupBlobPoly();
  
  // set stroke weight (for particle display) to 2.5
  strokeWeight(2.5);
  // initialize all particles in the flow
  for(int i=0; i<flow.length; i++) {
    flow[i] = new NoisyParticle(i/10000.0, kinect.width, kinect.height);
  }
  // set all colors randomly now
  setRandomColors(1);
}

void ex2_poly_flow_draw() {
  updateBlobPoly();
  
  if (debug) {
    debugShowBlobPoly();
  }
  
  // scale(2);
  // set global variables that influence the particle flow's movement
  float globalX = noise(frameCount * 0.01) * width/2 + width/4;
  float globalY = noise(frameCount * 0.005 + 5) * height;
  // update and display all particles in the flow
  for (NoisyParticle p : flow) {
    //p.updateAndDisplay(poly, globalX, globalY, scaleFactor);
  }
  // set the colors randomly every 240th frame
  setRandomColors(240);
}

// sets the colors every nth frame
void setRandomColors(int nthFrame) {
  if (frameCount % nthFrame == 0) {
    // turn a palette into a series of strings
    String[] paletteStrings = split(palettes[int(random(palettes.length))], ",");
    // turn strings into colors
    color[] colorPalette = new color[paletteStrings.length];
    for (int i=0; i<paletteStrings.length; i++) {
      colorPalette[i] = int(paletteStrings[i]);
    }
    // set background color to first color from palette
    bgColor = colorPalette[0];
    // set all particle colors randomly to color from palette (excluding first aka background color)
    for (int i=0; i<flow.length; i++) {
      flow[i].col = colorPalette[int(random(1, colorPalette.length))];
    }
  }
}