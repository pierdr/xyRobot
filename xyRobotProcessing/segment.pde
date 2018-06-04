class segment{ //<>//
   public int startX,startY;
   public int endX,endY;
   color col;
   int divider = 9;
   
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
      main.goToStart(startX,startY);
   }
   public void goToEnd()
   {
     main.goToEnd(endX,endY,color((int)(red(col)/divider),(int)(green(col)/divider),(int)(blue(col)/divider)));
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