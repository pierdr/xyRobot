import tramontana.library.*;
import websockets.*;

import controlP5.*;
import processing.serial.*;

ControlP5 cp5;
Serial arduino;




void setup()
{
  size(720,320);
  initP5();
  initSerial();
  initLogic();
  initTramotana();
}

void draw()
{
  background(255);
  serialEvent();
  color(0);
  text(segmentCounter,100,100);
}