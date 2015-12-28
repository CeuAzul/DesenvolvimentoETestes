// Pro_Graph2.pde
/*
 Used in the Youtube video "Arduino and Processing ( Graph Example )"
 Based in the Tom Igoe example.
 Mofified by Arduining 17 Mar 2012:
  -A wider line was used. strokeWeight(4);
  -Continuous line instead of vertical lines.
  -Bigger Window size 600x400.
-------------------------------------------------------------------------------
This program takes ASCII-encoded strings
from the serial port at 9600 baud and graphs them. It expects values in the
range 0 to 1023, followed by a newline, or newline and carriage return

Created 20 Apr 2005
Updated 18 Jan 2008
by Tom Igoe
This example code is in the public domain.
*/

import processing.serial.*;

Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph 

//Variables to draw a continuous line.
int XlastxPos=1;
int Xlastheight=0;

int YlastxPos=1;
int Ylastheight=0;

int ZlastxPos=1;
int Zlastheight=0;

PFont f;

void setup () {
  // set the window size:
  size(1000, 400);        

  // List all the available serial ports
  println(Serial.list());
  // Check the listed serial ports in your machine
  // and use the correct index number in Serial.list()[].

  myPort = new Serial(this, Serial.list()[0], 9600);  //

  // A serialEvent() is generated when a newline character is received :
  myPort.bufferUntil('\n');
  background(0);      // set inital background:
}
void draw () {
  // everything happens in the serialEvent()
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);                // trim off whitespaces.
    float[] inData = float(split(inString, ';'));

    inData[0] = map(inData[0], -5, 5, 0, height); //map to the screen height.
    inData[1] = map(inData[1], -5, 5, 0, height); //map to the screen height.
    inData[2] = map(inData[2], -5, 5, 0, height); //map to the screen height.

    //Drawing a line from Last inByte to the new one.
    strokeWeight(2);        //stroke wider
    
    stroke(255,0,0);     //stroke color
    line(XlastxPos, Xlastheight, xPos, height - inData[0]); 
    XlastxPos= xPos;
    Xlastheight= int(height-inData[0]);
    
    stroke(0,255,0);     //stroke color
    line(YlastxPos, Ylastheight, xPos, height - inData[1]); 
    YlastxPos= xPos;
    Ylastheight= int(height-inData[1]);
    
    stroke(0,0,255);     //stroke color
    line(ZlastxPos, Zlastheight, xPos, height - inData[2]); 
    ZlastxPos= xPos;
    Zlastheight= int(height-inData[2]);

    // at the edge of the window, go back to the beginning:
    if (xPos >= width) {
      xPos = 0;
      XlastxPos = 0;
      YlastxPos = 0;
      ZlastxPos = 0;
      background(0);  //Clear the screen.
    } 
    else {
      // increment the horizontal position:
      xPos++;
    }
     
        f = createFont("Arial",16,true); // Arial, 16 point, anti-aliasing on
    textFont(f,14);
    fill(0);
    rect(0, 30, 300, 60);
    fill(255);
    text("Somatório desvio Padrão:", 0, 50);
    text(inData[0], 180, 50);
    text(inData[1], 180, 60);
    text(inData[2], 180, 70);
  }
}

