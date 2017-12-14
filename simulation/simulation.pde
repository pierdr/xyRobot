import websockets.*;
WebsocketClient controller;

robot r;


void setup()
{
  size(660,660);
  r = new robot();
  try{
    controller= new WebsocketClient(this, "ws://localhost:8025/");
    controller.sendMessage("ciao");
  }
  catch(Exception e)
  {
    println(e);
  }
}

void draw()
{
  if(r.update()==1)
  {
     controller.sendMessage("done"); 
  }
  background(0);
  r.draw();
  
}
void webSocketEvent(String msg){
 
 JSONArray c = parseJSONArray(msg);
 println(c);
  if(c.size()==1)
  {
    if(c.getString(0)=="start")
    {
      r.start();
    }
    else if(c.getString(0)=="stop")
    {
      r.stop();
    }
  }
  else if(c.size()==2)
  {
    r.goTo(c.getInt(0),c.getInt(1));
  }
  else if(c.size()==5)
  {
    println(c.getInt(2),c.getInt(3),c.getInt(4));
     r.goTo(c.getInt(0),c.getInt(1), color(c.getInt(2),c.getInt(3),c.getInt(4)));
  }
}