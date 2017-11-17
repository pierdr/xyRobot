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
     stopRobot();
  }
}

public void moveLmCw(int theValue) {
  arduino.write("E-");
}
public void moveLmCCw(int theValue) {
  arduino.write("R-");
}
public void moveRmCcw(int theValue) {
  arduino.write("W-");
}
public void moveRmCw(int theValue) {
  arduino.write("Q-");
}
public void calibrate(int theValue) {
  arduino.write("C-");
}
public void drawSample(int theValue)
{
  sampleDraw();
  
}
public void printV(int theValue)
{
  arduino.write("T-");
}