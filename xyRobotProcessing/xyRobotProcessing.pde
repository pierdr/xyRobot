//** SIMULATOR **//
static final boolean isSimulated = true;


//** MORE **//
import tramontana.library.*;
import websockets.*;

import controlP5.*;
import processing.serial.*;

ControlP5 cp5;

controller main;




void setup()
{
  size(720,320);
  
  initP5();
  
  main = new controller(this,true);//TRUE -> simulation FALSE -> realmotors 
  
  initSerial();
  initLogic();
  initTramotana();
}

void draw()
{
  background(255);
  //serialEvent();
  main.updateSerial();
  color(0);
  text(segmentCounter,100,100);
}