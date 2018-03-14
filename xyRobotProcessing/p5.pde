void initP5()
{
  cp5 = new ControlP5(this);
  cp5.addButton("moveLmCCw");//.moveTo("LEFT MOTOR");
  cp5.addButton("moveLmCw");//.moveTo("LEFT MOTOR");
  
  cp5.addButton("moveRmCcw");//.moveTo("RIGHT MOTOR");
  cp5.addButton("moveRmCw");//.moveTo("RIGHT MOTOR");
  
  cp5.addButton("calibrate");
  
  cp5.addButton("drawSample");
  cp5.addButton("stop");
  cp5.addButton("printV");
  
}
public void stop(int theValue) {
  stopRobot();
  
}
void keyPressed()
{ 
  if(key=='s')
  {
     main.stopRobot();
  }
}

public void moveLmCw(int theValue) {
  main.moveMotor(LEFT,CW);
}
public void moveLmCCw(int theValue) {
  main.moveMotor(LEFT,CCW);
}
public void moveRmCcw(int theValue) {
  main.moveMotor(RIGHT,CCW);
}
public void moveRmCw(int theValue) {
 main.moveMotor(RIGHT,CW);
}
public void calibrate(int theValue) {
  main.calibrate();
}
public void drawSample(int theValue)
{
  startDrawing(); 
}
public void printV(int theValue)
{
  main.printValueDebug(); 
}