import processing.serial.*;

Serial myPort;        // The serial port
int positions = 1000;         // horizontal position of the graph 

float[] yVal = new float[positions]; 

PFont f;

void setup () {
  size(positions, 600);   
  
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);  //
  myPort.bufferUntil('\n');
  
  background(0);
  
  f = createFont("Arial",16,true);
  
  for(int i=0; i<yVal.length; i++)
  {
    yVal[i] = 0;
  }
}
void draw () {
}

void serialEvent (Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);                // trim off whitespaces.
    float inByte = float(inString);           // convert to a number.
    
    for(int i=0; i<yVal.length-1; i++)
    {
      yVal[i] = yVal[i+1];
      noSmooth();
      point(width, yVal[i]);
    }
    
    for(int i=0; i<yVal.length-1; i++)
    {
      yVal[i] = yVal[i+1];
    }
    
    yVal[yVal.length-1] = inByte;
       
    background(0);   
    stroke(255);  
    for(int i=1; i<yVal.length; i++)
    {  
      line(i-1, height/2 - yVal[i-1], i, height/2 - yVal[i]);
    }   
    
    noStroke();   
    fill(0);
    rectMode(CENTER);
    rect(100,100,100,100);
    textFont(f,16);                 // STEP 4 Specify font to be used
    fill(255);                        // STEP 5 Specify font color 
    text(inByte, 100, 100);  // STEP 6 Display Text
    
  }
}

