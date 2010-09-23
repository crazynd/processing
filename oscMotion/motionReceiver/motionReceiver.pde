import oscP5.*;
import netP5.*;

OscP5 oscP5;

Integer xPosition;
Integer yPosition;

/**
 * Receiver
 */
void setup() {
  size(400,400); // Anpassen!
  frameRate(25);
  //oscP5 = new OscP5(this, 60000);
  oscP5 = new OscP5(this, "239.0.0.12", 60000);
  xPosition = 200;
  yPosition = 200;
  smooth();
}

void draw() {
  background(0);
  stroke(255);               // sets the stroke color to white
  fill(102);
  noLoop();
  rectMode(CENTER);
  rect(xPosition, yPosition, 20, 20);
}

void oscEvent(OscMessage theOscMessage) {
  xPosition = int((theOscMessage.get(0).floatValue()+1.0)*200.0);
  yPosition = int((theOscMessage.get(1).floatValue()+1.0)*200.0);
  redraw();
}
