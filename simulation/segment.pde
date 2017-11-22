class segment{
  public color c;
  public float startX,startY;
  public float endX,endY;
  
  segment(float startX,float startY,float endX,float endY,color c)
  {
    this.c      =     c;
    this.startX =     startX;
    this.startY =     startY;
    this.endX   =     endX;
    this.endY   =     endY;
  }
  public void draw()
  {
      stroke(c);
      fill(c);
      line(startX,startY,endX,endY);
  }

}