
//** SIMULATOR **//

//** MORE **//

import tramontana.library.*;
import websockets.*;

import controlP5.*;
import processing.serial.*;

ControlP5 cp5;
Serial arduino;

controller main;


void setup()
{
  size(720,320);
  initP5();

  main = new controller(this,false);//TRUE -> simulation FALSE -> realmotors 
  initOSC();
  //initSerial();
  initLogic();
  
  main.calibrate();
  //initTramotana();
}

void draw()
{
  background(255);
  //serialEvent();
  text(state,100,100);
  main.updateSerial();
  color(0);
  text(segmentCounter,100,300);
}
