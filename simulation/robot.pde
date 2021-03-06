class robot{
  
  spool leftSpool;
  spool rightSpool;
  
  float currentPosX = width/2 ;
  float currentPosY = 10  ; 
  
  float startPosX = currentPosX;
  float startPosY = currentPosY;
  
  float targetPosX = 0;
  float targetPosY = 0;
  
  color currentColor = color(0,0,0);
  float lerpValue = 1.0;
  ArrayList<PVector> points;
  ArrayList<segment> segments;
  float recordTimeStart = 0;
  float recordTimeEnd  = 0;
  
  
  robot()
  {
    leftSpool = new spool(15,15);
    rightSpool = new spool(width-15,15);
    leftSpool.angle = 0.5;
    points = new ArrayList();
    segments = new ArrayList();
  }
  void draw()
  {
    leftSpool.draw();
    rightSpool.draw();
    
    //DRAW HEAD//
    stroke(77,77,77);
    fill(currentColor);
    ellipse(currentPosX,currentPosY,10,10);
    
    //DRAW LINES//
    stroke(80);
    fill(80);
    for(int i=1;i<points.size();i++)
    {
      line(points.get(i-1).x,points.get(i-1).y,points.get(i).x,points.get(i).y);
    }
    
    for(int i=1;i<segments.size()-1;i++)
    {
      
      segments.get(i).draw();
    }
    fill(currentColor);
    stroke(currentColor);
    line(startPosX,startPosY,currentPosX,currentPosY);
    fill(255);
    stroke(255);
    text(recordTimeEnd-recordTimeStart,100,100);
  }
  int update()
  {
    if(lerpValue >= 0 && lerpValue<1.0)
    {
      lerpValue+=0.3;
      currentPosX = lerp(startPosX,targetPosX,lerpValue);
      currentPosY = lerp(startPosY,targetPosY,lerpValue);
      recordTimeEnd = millis();
      if(lerpValue >=1.0)
      {
        //ARRIVED!
        
          points.add(new PVector(currentPosX, currentPosY));
        
        return 1;
      }
    }
    return 0;
  }
  void goTo(int x, int y)
  {
    goTo(x,y,color(0,0,0));
  }
  void goTo(int x, int y, color c)
  {
    lerpValue = 0.0;
    targetPosX = x;
    targetPosY = y;
    startPosX = currentPosX;
    startPosY = currentPosY;
    currentColor = c;
    
    if(c!=color(0,0,0))
    {
      segments.add(new segment(currentPosX,currentPosY,x,y,c));
    }  
  }
  void start()
  {
    points.clear();
    segments.clear();
    recordTimeStart = millis();
  }
  void stop()
  {
    points.clear();
    segments.clear();
    recordTimeEnd = millis();
    
  }
}