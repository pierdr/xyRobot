import controlP5.*;
import processing.serial.*;

ControlP5 cp5;
Serial arduino;

void setup()
{
  size(520,320);
  initP5();
  String portName = Serial.list()[1];
  arduino = new Serial(this, portName, 115200);
  
}

void draw()
{
  background(255);
  serialEvent();
}