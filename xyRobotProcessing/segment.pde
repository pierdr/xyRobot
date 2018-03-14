class segment{
   public int startX,startY;
   public int endX,endY;
   color col;
   int divider = 3;
   
   segment(int sX,int sY,int eX, int eY, color c)
   {
     startX = sX;
     startY = sY;
     endX   = eX;
     endY   = eY;
     col    = c;
   }
   public void goToStart()
   {
      arduino.write("l"+startX+","+startY+"-");
      robotHead.setColorEmbedded(0,0,0,0);
   }
   public void goToEnd()
   {
     arduino.write("l"+endX+","+endY+"-");
     //robotHead.setColorEmbedded(0,255,0,0);
     robotHead.setColorEmbedded(0,(int)(red(col)/(divider)),(int)(green(col)/divider),(int)(blue(col)/(divider)));
   }
   public void swapEndWithStart()
   {
     int startXTmp = startX;
     int startYTmp = startY;
     startX = endX;
     startY = endY;
     endX = startXTmp;
     endY = startYTmp;
   }
}