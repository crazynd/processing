import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteHost;
Integer index;
Boolean paused;

/**
 * Sender
 */
void setup() {
  size(400,400);
  frameRate(25);
  oscP5 = new OscP5(this, "239.0.0.12", 60000);
  index = 0;
  paused = false;
}

private Float normalizeCoordinate(Float x) {
  return x/400;
}

private Float calculateYCoordinate(Float x) {
  return sin(radians(x));
}

private void sendCoordinates(Float x, Float y) {
  OscMessage m = new OscMessage("/motion/xPosition");
  m.add(x);
  m.add(normalizeCoordinate(y));
  println("Added "+index+", "+normalizeCoordinate(x)+", "+normalizeCoordinate(calculateYCoordinate(x)));
  oscP5.send(m);
} 


void draw() {
  background(0);
  loop();
  //  sendCoordinates(float(mouseX), float(mouseY));
  manageIndex();
  sendCoordinates(signal(index), signal(index));

  //sendCoordinates(signal(frameCount), signal(frameCount));
}

private float signal(int a) {
  //println(a+", radians: "+radians(a)+" sin: "+sin(radians(a)));
  return sin(radians(a*10));
}

private void manageIndex() {
  if(index < 360) {
    index += 1;
  } 
  else if (index == 360) {
    index = 0;
  }
}

void keyPressed() {
  if(value == "p") {
    if(paused) {
      loop();
      paused = false;
    } 
    else {
      noLoop();
      paused = true;
    }
  }
}

