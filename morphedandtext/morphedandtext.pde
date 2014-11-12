/*
MORPHED IMAGE AND TEXT
created for DIGF6L01.
An image captured from the FaceMorphAutofade sketch is cropped to include just the required pixels. 
A text animation fades in and out using opacity levels.
The imagetext is sent to VPT via Syphon for adjustment and projection.

11 November 2014 
by Sachiko Murakami
*/

import codeanticode.syphon.*;

PGraphics canvas;
SyphonServer server;


PImage morphedpic;
PImage picframe;

PFont font;
int meopacity = 255;
int youopacity = 0;
int whatopacity = 255;
int medirection = 1;
int youdirection = 1;
int whatdirection = 1;
String what = "WHAT";  // each word is animated individually.
String me = "ME";
String you = "YOU";
String happens  = "HAPPENS";
String to  = "TO";
int x=0;
int count = 0;
int savedframe=1;

boolean reverse = false;

void setup() {
  size(640, 480, P2D);
  canvas = createGraphics(640, 480, P2D); // this creates a lot of trouble for the font (i.e. it doesn't load properly)
  server = new SyphonServer(this, "Processing Syphon");
  font = createFont("EurekaSmallCaps-50.vlw", 50);
  
//  savedframe=1;
   

 morphedpic = loadImage("../FaceMorphAutoFade/morphedpic.jpg");
  // was trying to animate an array of images.
  //morphedpic = loadImage("../libraries/FaceMorphAutoFade/test"+savedframe+".jpg"); 
  //pic1frame = pic1.get(106, 81, 111, 116);
  //pic2frame = pic2.get(106, 81, 111, 116);
   //  for(int i = 1; i <=10; i++) {
   //    PImage morphedpic + i = loadImage("../libraries/FaceMorphAutoFade/test"+i+".jpg");
  //  }
 picframe = morphedpic.get(0, 300, 640, 480);
}

void draw() {
canvas.beginDraw();
//morphedpic = loadImage("../libraries/FaceMorphAutoFade/test"+savedframe+".jpg"); 
canvas.background(204);

// displays the image
canvas.image(picframe, 0, 0, morphedpic.width, morphedpic.height);

// word animations
canvas.smooth();
canvas.textFont(font);

canvas.fill(0, youopacity);
canvas.text(what, 22, 425);

canvas.fill(0);
canvas.text(happens, 182, 425);

canvas.fill(0);
canvas.text(to, 411, 425);

canvas.fill(0, meopacity);
canvas.text(me, 500, 425);

canvas.fill(0, youopacity);
canvas.text(you, 489, 425);

// creates opacity fade in/out
 meopacity += 1 * medirection;
  youopacity += 1 * youdirection;
  whatopacity += 1 * whatdirection;
  
  if (meopacity < 0 || meopacity > 255)  
  {
   medirection = -medirection;
  }

if (youopacity < 0 || youopacity > 255) 
  {
   youdirection = -youdirection;
  }


//  animateface();
  canvas.endDraw(); // Always end with endDraw
  image(canvas, 0, 0); // draws the canvas to the window
  server.sendImage(canvas); // sends the image to VPT

}

/*
// I was trying to roll through an array of images, but it didn't work.

void animateface(){
if (reverse == false) {
    println(savedframe);
    savedframe+=1;
    }
    if (savedframe==10) {
    reverse = true;
    }
    if (savedframe==1) {
      reverse = false;
    }  
    if (reverse == true){
    savedframe-=1;
    }
}
*/
