
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
  frameRate(24);
  main.calibrate();
  //initTramotana();
}

void draw()
{
  background(255);
  //serialEvent();
  
  main.updateSerial();
  fill(0);
  text("state:",20,200);
  text(state,90,20);
  text("segments:",20,240);
  text(segmentCounter,90,240);
  text("drawing:",20,280);
  text(countDrawings,90,280);
}