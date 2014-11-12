/* 
FaceMorph with auto-morph.
created for DIGF6L01.
Based on Daniel Shiffman's FaceMorph.
Creates a morphed image based on corresponding points of two images.
I added the automatic morphing image with the intention of sending it to VPT and then overlay the text
animation (or incorporate it here), but the VPT format proved too unwieldy.

11 November 2014
*/
// Two images
PImage a;
PImage b;
PImage a1;
PImage b1;
// A Morphing object
Morpher morph;

// How much to morph, 0 is image A, 1 is image B, everything else in between
float amt =  0;
// Morph bar position
float x = 100; 
float i = 0;
boolean reverse=false;

int time;
int wait = 500;

int framesaved = 1;

void setup() {
  time = millis();//store the current time
  size(960, 800, P2D);

  // Load the images
 a1 = loadImage("../whtmhty/data/testface.jpg");
 b1 = loadImage("../whtmhty/data/testface2.jpg");
 
 // SM: crop the images
 a = a1.get(150, 100, 400, 300);
 b = b1.get(150, 100, 400, 300);

  // Create the morphing object
  morph = new Morpher(a, b);
}

void draw() {


  background(0);

  pushMatrix();

  // Show Image A and its triangles
  morph.displayImageA();
  morph.displayTrianglesA();

  // Show Image B and its triangles
  translate(a.width, 0);
  morph.displayImageB();

  translate(-a.width, a.height);

  // Update the amount according to mouse position when pressed
  if (mousePressed && mouseY > a.height) {
    x = constrain(mouseX, 100, width-100);
    amt = map(x, 100, width-100, 0, 1);
  }

  // Morph an amount between 0 and 1 (0 being all of A, 1 being all of B)
  morph.drawMorph(amt);
  

  popMatrix();

  // Have you clicked on the images?
  if (va != null) {
    fill(255, 0, 0);
    ellipse(va.x, va.y, 8, 8);
  }
  if (vb != null) {
    fill(255, 0, 0);
    ellipse(vb.x, vb.y, 8, 8);
  }



  // Draw bar at bottom
  stroke(255);
  line(100, height-50, width-100, height-50);
  stroke(255);
  line(x, height-75, x, height-25);

animateface();

}

// Save or load points based on key presses
void keyPressed() {
  if (key == 's') {
    morph.savePoints();
  } 
  else if (key == 'l') {
    morph.loadPoints();
  } else if (key == 'p'){
  saveFrame("morphedpic.jpg"); // saves the image
  } else if (key == 'm'){
    saveFrame("test"+framesaved+".jpg"); // SM: was saving the images as automatically numbered in the hopes I could have animated them in the final sketch. Didn't work.
    framesaved +=1;
  }
// }
}
  // Morph an amount between 0 and 1 (0 being all of A, 1 being all of B)
  



// Variables to keep track of mouse interaction
int counter = 0;
PVector va;
PVector vb;

void mousePressed() {
  
  
  // If we clicked on an image
  if (mouseY < a.height) {
    // Point on image A first
    if (counter == 0) {
      va = new PVector(mouseX, mouseY);
    } 
    // Corresponding point on image B
    else if (counter == 1) {
      PVector vb = new PVector(mouseX-a.width, mouseY);
      morph.addPair(va, vb);
    }
    // Increment click counter
    counter++;
    if (counter == 2) {
      // Start over
      counter = 0;
      va = null;
      vb = null;
    }
  }
}

// SM: function to create the automatic morphing
void animateface(){
if (reverse == false) {
    amt+=0.005;
    }
    if (amt>1) {
    reverse = true;
    }
    if (amt<0) {
      reverse = false;
    }  
    if (reverse == true){
    amt-=0.005;
    }
}
