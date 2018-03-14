<<<<<<< HEAD
=======
//** SIMULATOR **//

//** MORE **//
>>>>>>> f1e93b8621bf6d006f8107dc8d5aca0f97867a21
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
<<<<<<< HEAD
=======
  
  main = new controller(this,true);//TRUE -> simulation FALSE -> realmotors 
  
>>>>>>> f1e93b8621bf6d006f8107dc8d5aca0f97867a21
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