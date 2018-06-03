import oscP5.*;
import netP5.*;

OscP5 oscDeamon;
NetAddress visualization;

void initOSC(){
      oscDeamon = new OscP5(this,9091);
      visualization = new NetAddress("127.0.0.1",9090);
}
void startOSC()
{
  
  OscMessage myMessage = new OscMessage("/robot/start");

  oscDeamon.send(myMessage, visualization); 
}
void stopOSC()
{
  
  OscMessage myMessage = new OscMessage("/robot/stop");

  oscDeamon.send(myMessage, visualization); 
}
void updateOSCPosition(int x, int y, color c, int currentCountNum, int totalCountNum )
{
  
  OscMessage myMessage = new OscMessage("/robot/position");
  myMessage.add(x); /* add an int to the osc message */
  myMessage.add(y); /* add a float to the osc message */
  myMessage.add(red(c));
  myMessage.add(green(c));
  myMessage.add(blue(c));
  myMessage.add(currentCountNum);
  myMessage.add(totalCountNum);

  oscDeamon.send(myMessage, visualization); 
}
