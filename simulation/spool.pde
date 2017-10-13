class spool{
   float angle = 0.0;
   int x=0;
   int y=0;
  spool(int newX, int newY){
    x = newX;
    y = newY;
  }
  
  void draw()
  {
    noStroke();
    fill(232,232,232);
    ellipse(x,y,18,18);
    fill(187);
    ellipse(x+( sin(angle)*5),y+( cos(angle)*5),3,3);
    
  }
}