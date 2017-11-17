//** SIMULATOR **//
static final boolean isSimulated = true;


//** CONNECTIONS **//
import tramontana.library.*;
import websockets.*;

import controlP5.*;
import processing.serial.*;



ControlP5 cp5;


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
  
}