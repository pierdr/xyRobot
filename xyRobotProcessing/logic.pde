final static int INIT = 0;
final static int IDLE = 1;
final static int DRAW = 2;

final static int GO_TO_START  = 3;
final static int DRAW_SEGMENT = 4;
final static int NEXT_SEGMENT = 5;
/*
if(HAS_CAMERA_OF)
     {
        updateOSCPosition(endX,endY,c); 
     }
     */


final static String fileName = "faces2/000.txt";//"PSYCHO640/039.txt";//"8_0_log.txt";//"20_34_log.txt";//"calibrate_test.txt";//"17_55_log.txt";//"calibrate_test.txt";//"PSHYCO/001_log.txt";


final static boolean multipleDrawings = true;
final static int numDrawings = 92;
int countDrawings = 1;


int state = INIT;
 

ArrayList<segment> segments;
int segmentCounter=0;

void initLogic()
{
  changeState(IDLE);
  segments = new ArrayList();
  loadImgFromFile(fileName);
}
void logicUpdate()
{
  
}

void changeState(int newState){
  switch(newState)
  {
    case INIT:
    break;
    case IDLE:
    break;
    case DRAW:
    
    break;
  }
  state = newState;
  
}

void sampleDraw()
{
  
  segments.clear();
 
  loadImgFromFile(fileName);

  startDrawing();
}

void startDrawing()
{
   
  segmentCounter = 0; //<>// //<>//
 
  main.startDrawing();

  changeState(GO_TO_START);
  println("size segments:"+segments.size());
  
  segments.get(segmentCounter).goToStart();
  //main.goToStart(segments.get(segmentCounter).startX,segments.get(segmentCounter).startY);
  
 
}
void arrivedToPoint()
{
  println("arrivedToPoint");
  if(state == DRAW_SEGMENT)
  {
    //go to start
      segmentCounter++;
      //cameraRemote.setRelayEmbedded(RELAY_NUM,1);
      //delay(400);
      // cameraRemote.setRelayEmbedded(RELAY_NUM,0);
      println(segmentCounter);
      // check if last segment
     if(segmentCounter>=segments.size())
     {
       //finish draw
       stopRobot();
     }
     else
     {
       changeState(GO_TO_START);
       segments.get(segmentCounter).goToStart();
       updateOSCPosition(segments.get(segmentCounter).startX,segments.get(segmentCounter).startY,segments.get(segmentCounter).col,segmentCounter,segments.size()); 
     }
  }
  else if(state == GO_TO_START)
  {
    //print the segment
    changeState(DRAW_SEGMENT);
    segments.get(segmentCounter).goToEnd();
     updateOSCPosition(segments.get(segmentCounter).endX,segments.get(segmentCounter).endY,segments.get(segmentCounter).col,segmentCounter,segments.size());
  }
}
void stopRobot()
{
   if(multipleDrawings)
   {
     if(countDrawings<numDrawings)
     {
       changeState(IDLE);
       
       segments = new ArrayList();
       String name = (String)((countDrawings<10)?("00"+countDrawings):((countDrawings>=10 && countDrawings<100)?("0"+countDrawings):(countDrawings+"")));
       boolean fileExists = loadImgFromFile("faces2/"+name+".txt");
       countDrawings++;
      
       if(fileExists && segments.size()>0)
       {
          main.closeShutter();
          
          delay(12200);
         
          startDrawing();
       }
       else
       {
         main.stopRobot();
         changeState(IDLE);
       }
     }
     else
     {
       main.stopRobot();
       changeState(IDLE);
     }
   }
   else
   {
       main.stopRobot();
       changeState(IDLE);
   }   
}
void addPart1()
{
  

}
boolean loadImgFromFile(String fileName)
{
  
 
  File f = new File(dataPath(fileName));
   
  if (f.exists())
  {
    println("load");
  }
  else
  {
    println("error - no such file\n ->  "+fileName);
    return false;
  }
  println("load");
  String[] lines = loadStrings(fileName);
  int x1,y1,x2,y2;
  
  for (int i = 0 ; i < lines.length; i++) {
    String result[] = split(lines[i], ',');
    if(result.length>=6)
    {
    //println(result[6],parseFloat(result[6]),parseInt(result[5]),parseInt(result[6]));
    x1 = constrain((int)(((float)parseInt(result[2]))*1.4),0,640);
    y1 = constrain((int)(((float)parseInt(result[3]))*1.4),0,640);
    x2 = constrain((int)(((float)parseInt(result[0]))*1.4),0,640);
    y2 = constrain((int)(((float)parseInt(result[1]))*1.4),0,640);
    segments.add(new segment(x1,y1,x2,y2,color(parseInt(result[4]),parseInt(result[5]),parseInt(result[6]))));
    }  
  }
  try
  {
    sortSegments();
  }
  catch(Exception e)
  {
    println(e);
  }
  return true;
  
}
void sortSegments()
{
  if(segments.size()==0)
  {
    return;
  }
  ArrayList<segment> unorderedSegments=new ArrayList();
  for(int i=0;i<segments.size();i++)
  {
    unorderedSegments.add(segments.get(i));
  }
  segments.clear();
  int countTmp = 0;
  
  segment focusSegment = unorderedSegments.get(0);
  int X1 = 10;
  int Y1 = 10;
  while(unorderedSegments.size()>0){
    int selected = -1;
    float minDist = 100000;
    boolean isInverted=false;
    for(int i=0;i<unorderedSegments.size();i++)
    {
      float distA = sqrt(sq(unorderedSegments.get(i).startX-focusSegment.endX)+sq(unorderedSegments.get(i).startY-focusSegment.endY));
      float distB = sqrt(sq(unorderedSegments.get(i).endX-focusSegment.endX)+sq(unorderedSegments.get(i).endY-focusSegment.endY));
      if(distA<minDist)
      {
        selected = i;
        minDist = distA;
      }
      if(distB<minDist)
      {
        isInverted = true;
        selected = i;
        minDist = distB;
      }
    }
    if(isInverted)
    {
      unorderedSegments.get(selected).swapEndWithStart();
    }
    focusSegment = unorderedSegments.get(selected);
    unorderedSegments.remove(selected);
    segments.add(focusSegment);
  }
}
void loadImg()
{
 
}