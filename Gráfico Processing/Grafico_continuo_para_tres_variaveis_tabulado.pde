import processing.serial.*;

Serial myPort;        		// The serial port
int positions = 1000;       // Number of horizontal positions on the graph 

float[] y1Val = new float[positions]; 
float[] y2Val = new float[positions]; 
float[] y3Val = new float[positions]; 

PFont f;

void setup () {
  size(positions, 600);   
  
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 9600);  //
  myPort.bufferUntil('\n');
  
  background(0);
  
  f = createFont("Arial",16,true);
  
  for(int i=0; i<y1Val.length; i++)
  {
    y1Val[i] = 0; //Zera o vetor de posições para o inicio do programa
  	y2Val[i] = 0;
  	y3Val[i] = 0;
  }
}

void draw () {
}

void serialEvent (Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);                // trim off whitespaces.
    float[] inData = float(split(inString, ';'));           // convert to a number.
   
    for(int i=0; i<y1Val.length-1; i++)
    {
      y1Val[i] = y1Val[i+1];
      y2Val[i] = y2Val[i+1];
      y3Val[i] = y3Val[i+1];
      noSmooth();
      point(width, y1Val[i]);
      point(width, y2Val[i]);
      point(width, y3Val[i]);
    }
    
    for(int i=0; i<y1Val.length-1; i++)
    {
      y1Val[i] = y1Val[i+1];
      y2Val[i] = y2Val[i+1];
      y3Val[i] = y3Val[i+1];
    }
    
    y1Val[y1Val.length-1] = inData[0];
    y2Val[y2Val.length-1] = inData[1];
    y3Val[y3Val.length-1] = inData[2];
       
    background(0);   
    stroke(255);  
    for(int i=1; i<y1Val.length; i++)
    {  
      stroke(255,0,0); 
      line(i-1, height/2 - y1Val[i-1], i, height/2 - y1Val[i]);
      stroke(0,255,0);
      line(i-1, height/2 - y2Val[i-1], i, height/2 - y2Val[i]);
      stroke(0,0,255);
      line(i-1, height/2 - y3Val[i-1], i, height/2 - y3Val[i]);
    }   
    
    noStroke();   
    fill(0);
    rectMode(CENTER);
    rect(100,100,100,100);
    textFont(f,16);                 // STEP 4 Specify font to be used
    fill(255);                        // STEP 5 Specify font color 
    text(inData[0], 100, 100);  // STEP 6 Display Text
    text(inData[1], 200, 100);  // STEP 6 Display Text
    text(inData[2], 300, 100);  // STEP 6 Display Text
    
  }
}

