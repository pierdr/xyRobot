final static int RIGHT = 1;
final static int LEFT =  0;
final static int CCW  = 2;
final static int CW   = 3;

class controller{
  
  boolean isSimulated = false;
  
  Serial arduino;
  
  Tramontana cameraRemote;
  Tramontana robotHead;
  
  WebsocketServer simulator;
  
  final static int RELAY_NUM = 1;
  
  String inputString;

  controller(PApplet parent, boolean isSimulated)
  {
    this.isSimulated = isSimulated;
    if(!isSimulated)
    {
      try{
        cameraRemote = new Tramontana(parent,"192.168.1.14");
        robotHead = new Tramontana(parent,"192.168.1.16");
        cameraRemote.setRelayEmbedded(RELAY_NUM,1);
        
        String portName = Serial.list()[1];
        println(Serial.list());
        arduino = new Serial(parent, portName, 115200);
      }
      catch(Exception e)
      {
        
      }
    }
    else
    {
      simulator= new WebsocketServer(parent,8025,"/");
    }
  }
  controller(PApplet parent)
  {
    this(parent,false);
  }
 void updateSerial() {
   if(!isSimulated)
   {
  while (arduino.available()>0) {
    // get the new byte:
    
    char inChar = (char)arduino.read();
    // add it to the inputString:
    println(inputString);
    // if the incoming character is a newline, set a flag so the main loop can
    // do something about it:
    if (inChar == '-' || inChar=='\n') {
        println("::"+inputString+"::");
        if(inputString.equals("L"))
        {
          println("going to point");
          arrivedToPoint();
        }
        inputString = "";
    }
    else
    {
      inputString += inChar;
    }
  }
   }
}
void startDrawing()
{
  if(!isSimulated)
  {
    cameraRemote.setRelayEmbedded(RELAY_NUM,0);
  }
  else{
     simulator.sendMessage("[\"start\"]");
  }
}
void stopRobot()
{
  if(!isSimulated)
  {
       robotHead.setColorEmbedded(0,0,0,0);
       cameraRemote.setRelayEmbedded(RELAY_NUM,1);
      arduino.write("l320,0-");
  }
  else
  {
    simulator.sendMessage("[\"stop\"]");
  }
}
void goToStart(int startX, int startY)
{
  if(!isSimulated) //<>//
  {
      arduino.write("l"+startX+","+startY+"-");
      robotHead.setColorEmbedded(0,0,0,0);
  }
  else
  {
    simulator.sendMessage("["+startX+","+startY+"]");
  }
}
void goToEnd(int endX, int endY, color c )
{
  if(!isSimulated)
  {
      arduino.write("l"+endX+","+endY+"-");
     robotHead.setColorEmbedded(0,(int)(red(c)),(int)(green(c)),(int)(blue(c)));
  }
  else
  {
    simulator.sendMessage("["+endX+","+endY+","+(int)(red(c))+","+(int)(green(c))+","+(int)(blue(c))+"]");
  }
}

void moveMotor(int side, int orientation)
{
  if(side == RIGHT)
  {
    if(orientation ==  CCW)
    {
      arduino.write("W-");
    }
    else if(orientation == CW)
    {
      arduino.write("Q-");
    }
  }
  if(side == LEFT)
  {
    if(orientation ==  CCW)
    {
      arduino.write("R-");
    }
    else if(orientation == CW)
    {
      arduino.write("E-");
    }
  }
}
void calibrate()
{
  arduino.write("C-");
}
void printValueDebug()
{
  arduino.write("T-");
}
  
}

void webSocketServerEvent(String msg){
   println(msg);
   if(msg.equals("done"))
   {
     arrivedToPoint();
   }
  }