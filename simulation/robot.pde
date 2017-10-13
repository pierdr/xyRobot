class robot{

  spool leftSpool;
  spool rightSpool;
  
  robot()
  {
    leftSpool = new spool(15,15);
    rightSpool = new spool(width-15,15);
    leftSpool.angle = 0.5;
  }
  void draw()
  {
    leftSpool.draw();
    rightSpool.draw();
  }

}