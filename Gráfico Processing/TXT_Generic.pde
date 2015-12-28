PrintWriter output;
import processing.serial.*;

Serial myPort;        // The serial port


void setup() {
  // Create a new file in the sketch directory
  output = createWriter("Som azul.txt"); 
  
  // List all the available serial ports
  println(Serial.list());
  // Check the listed serial ports in your machine
  // and use the correct index number in Serial.list()[].

  myPort = new Serial(this, Serial.list()[0], 9600);  //

  // A serialEvent() is generated when a newline character is received :
  myPort.bufferUntil('\n');
  
}

void draw() {

}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);                // trim off whitespaces.
     output.println(inString);               // Write the coordinate to the file
  }
}

void keyPressed() {
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  exit(); // Stops the program
}

