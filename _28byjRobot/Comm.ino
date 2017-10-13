


void serialEvent() {
 while (Serial.available()) {
    inChar = (char)Serial.read();
    
    if (inChar == '-') {
      stringComplete = true;
     
    }
    else
    {
       inputString += inChar;
    }
  }
}
void updateCommands()
{
  
  if (stringComplete) {
    Serial.print("test:");
    Serial.println(inputString);
    //MOVE LEFT MOTOR CW
    if(inputString=="E")
    {
      Serial.println("move left motor cw");
        mm.moveLeftMotor(true,128);
    }
    //MOVE LEFT MOTOR CCW
    else if(inputString == "R")
    {
      Serial.println("move left motor ccw");
        mm.moveLeftMotor(false,128);
    }
    //MOVE RIGHT MOTOR CW
    else if(inputString=="Q")
    {
      Serial.println("move right motor cw");
        mm.moveRightMotor(true,128);
    }
    //MOVE RIGHT MOTOR CCW
    else if(inputString == "W")
    {
      Serial.println("move right motor ccw");
        mm.moveRightMotor(false,128);
    }
    else if(inputString == "T")
    {
      
        mm.print();
    }
    //CALIBRATE
    else if(inputString=="C")
    {
     mm.calibrate();
    }
    //MOVE
    else if(inputString.indexOf("l")!=-1)
    {
        workingString=inputString.substring(1);
        if(workingString=="" || workingString==" ")
        {
          inputString="";
        
          return;
        }
        
       // workingCstr = new char [workingString.length()+1];
       // strcpy (workingCstr, workingString.c_str());
       // workingCstr=workingString.c_str();
        //extract x and y
        char* copy = strdup(workingString.c_str());

        workingX=atof(strtok(copy, delimiter));
        workingY=atof(strtok(NULL, delimiter));

        free(copy);
        mm.moveTo(workingX,workingY);
        inputString=F("");
      }
        // clear the string:
      inputString = "";
      stringComplete = false;
    }
}
void changeState(int newState)
{
  state=newState;
}
void serialAlive()
{
  if(millis()-eventTime>7500)
  {
    eventTime=millis();
    Serial.print(F("Z"));
  }
}
void convertCoordinates(float x,float y)
{
   //calculate 
   x/=10.0;
   y/=10.0;
  
   //positions[0]=(sqrt(sq(HALF_L+(x-FRAME_ORIGIN_X))+sq(y+FRAME_ORIGIN_Y)))/CM_TO_STEP;   
   //positions[1]=(sqrt(sq(HALF_L-(x-FRAME_ORIGIN_X))+sq(y+FRAME_ORIGIN_Y)))/CM_TO_STEP;   
}


