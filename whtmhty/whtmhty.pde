/* 
WHAT HAPPENS TO ME HAPPENS TO YOU
Three sketches used for this process: whthmhty.pde, FaceMorphAutoFade.pde, and MorphedandText.pde.

This sketch uses a OpenCV face recognition library to identify faces.
Visual and text cues help the user position their face in the centre so the image processing in subsequent sketches is smoother.
Two images are created: testface.jpg (the first image taken) and testface2.jpg (the second image taken).
These images are stored in the /data directory and opened by the FaceMorphAutoFade sketch.


*/


PFont myFont;
String displayDone = "First picture taken";
String displayAllDone = "Second picture taken";
String displayNothing = "";
String displayHint = "Please put your face in the frame.";
String displayNothing2 = "";
String display;
String display2;

// for timers
int realTime1;
int realTime2;
int startTime1 = 0;
int startTime2 = 0;
int passedTime1;
int passedTime2;
boolean enoughTime=false;
// for video
import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;


// for finding nose
float centerToNose;

// to determine whether picture has been taken
boolean picTaken1 = false;
boolean picTaken2 = false;
boolean reStart1 = false;


void setup() {
 
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  video.start();
  myFont = createFont("KozGoPro", 32);  
  
}


void draw() {
  scale(2);
  opencv.loadImage(video);
  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  // uses OpenCV to draw a rectangle around a face, and adds a hint to help the user position their face correctly.
  Rectangle[] faces = opencv.detect();
  stroke(156, 0, 255);
  // draws the positioning rectangle (target area for face, to make sure the face is the proper distance from the camera)
  rect((width/10)+42, (height/10)+13, (width/10)+47, (width/10)+52);
  text(displayHint, (width/10), (height/10));  

  for (int i = 0; i < faces.length; i++) {
  // draws the face-framing rectangle.
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    
   // draws a circle around where the nose approximately should be within the positioning rectangle (ideal nose location)   
    ellipse((faces[i].x+(faces[i].width/2)), (faces[i].y+(faces[i].height/2)),30,30);
   
   // measures the distance from the user's nose to the 'ideal' nose location and draws a line to indicate that the user should match their nose to the centre.
     centerToNose=dist((faces[i].x+(faces[i].width/2)),(faces[i].y+(faces[i].height/2)),width/4,height/4);
    line((faces[i].x+(faces[i].width/2)),(faces[i].y+(faces[i].height/2)),width/4,height/4);
    
  // for timers.
  realTime1 = millis()/1000;
  realTime2 = millis()/1000;
  passedTime1=realTime1-startTime1;
  passedTime2=realTime2-startTime2;
  println(passedTime1);
    
  }
// sets up text display.
display=displayNothing;
text(display, width/2, height/2);   

  matchIt();

// Timers determine whether or not the first or second picture have been taken, 
//adds a delay before the second picture can be taken, and dispays a "done" message 
//to indicate to the user that the picture has been taken.
 if (passedTime1 < 5 && passedTime1 > 0 && picTaken1==true){
   text(displayDone, 100, 20);
 }
 if (picTaken1 == true && passedTime1 > 10){
   enoughTime = true;
 }
 if (passedTime2 < 5 && passedTime2 > 0 && picTaken2==true){
   text(displayAllDone,100,20);
 }
}


void captureEvent(Capture c) {
  c.read();

}

// detects when the nose is in the required position, takes a picture, and starts a timer (for first picture)

void matchIt() { 
if (centerToNose < 5 && centerToNose > 0 && picTaken1==false)  // i.e. if no picture has been taken yet and the face is in the right place,
{
   image(video, 0, 0 );   // redraws the frame really quickly to erase the guide lines
   saveFrame("data/testface.jpg");  // saves the picture
   stroke(0, 0, 0); // trying to change the lines
   println("match!");
   startTime1=realTime1;  // starts the timer
   passedTime1=startTime1;
   picTaken1=true;

   } 
if (centerToNose < 5 && centerToNose > 0 && picTaken1==true && picTaken2==false && enoughTime==true)
 {    
  image(video, 0, 0 );   // redraws the frame really quickly
   saveFrame("data/testface2.jpg");  // saves the picture
   stroke(0, 0, 0); // trying to change the lines
   println("match2!");
   startTime2=realTime2;
   passedTime2=startTime2;
   picTaken2=true;
   }
}   
 


