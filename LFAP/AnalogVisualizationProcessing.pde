/*
*  By Hannah Perner-Wilson, www.plusea.at
*  Modified 3/30/2012 By Brian E Kaminski, www.AdvancerTechnologies.com
*
*  IMPORTANT!!:
*  Scroll down to set your serial port
*  Scroll down to set your thresholds
*/

import processing.serial.*;

// definition of window size
// you can change the size of the window as you like
// the thresholdGraph will be scaled to fit
// the optimal size for the thresholdGraph is 1000 x 400
int xWidth = 1200;
int yHeight = 750;
PImage backgroundimg; 

// xPos input array, using prefix
int[] xPosArr= {0,0,0,0,0,0}; 

// 
int[] messageArr= {0,0,0,0,0,0}; 
  
// Arrays for threshholding
int[] threshMax= {0,0,0,0,0,0}; 
int[] threshMin= {0,0,0,0,0,0}; 
  
// variables for serial connection. portname and baudrate are user specific
Serial port1;

//Set your serial port here (look at list printed when you run the application once)
String V3 = Serial.list()[1];
String portname1 = V3;
int baudrate = 9600;
  
int prefix = 10001;
boolean myCatch = false;
String serialIN = "";
String serialINPUT = ""; 
String buffer = ""; 
int value = 0; 

float score = 1;
// ThresholdGraph draws grid and poti states
ThresholdGraph in;


void setup(){
  // set size and framerate
  size(xWidth, yHeight);
  frameRate(25);
  background(255);
  strokeWeight(5);
  stroke(0);
  smooth();
  strokeCap(ROUND);
  backgroundimg = loadImage("steelframe4.jpg");
  backgroundimg.resize(width,height);

  // establish serial port connection      
  port1 = new Serial(this, portname1, baudrate);
  port1.bufferUntil('\n') ;
  println(Serial.list());  // print serial list

  // create DisplayItems object
  in = new ThresholdGraph();
  
  // THRESHOLD VALUES:
  // using the thresholdGraph you can determine the MIN and MAX values
  // of your sensors. Enter these here. They must lie between 0 and 1000.
  
    //MIN trashhold
    threshMin[0] = 100;   // one
    threshMin[1] = 100;   // two
    threshMin[2] = 100;   // three
    threshMin[3] = 100;   // four
    threshMin[4] = 100;   // five
    threshMin[5] = 100;   // six
    
    //MAX trashhold
    threshMax[0] = 400;   // one
    threshMax[1] = 400;   // two
    threshMax[2] = 400;   // three
    threshMax[3] = 400;   // four
    threshMax[4] = 400;   // five
    threshMax[5] = 400;   // six
}//end setup

// draw listens to serial port, draw 
void draw(){
  
  // listen to serial port and trigger serial event  
  while(port1.available() > 0){
        serialIN = port1.readStringUntil('\n');
        //println((int)float(serialIN));
        if(serialIN != "")
          serialEvent(serialIN);  
        else
          println("found empty");
        }
        
  // threshold serial input  
  threshHolding();  

  // draw serial input
  in.update();
}//end draw()
