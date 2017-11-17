#define HALFSTEP 8
class Motor{
  CheapStepper *stepper;
  int currentSteps  = 0;
  int targetSteps   = 0;
  int totalTravel   = 0;
  int workingSteps  = 0;
  int startingSteps = 0;
  int magnitudeSteps = 0;
  boolean dir;
  int index=0;
  
  
  public:
  Motor::Motor(int pin1,int pin2, int pin3, int pin4, boolean invDirection)
  {
    stepper = new CheapStepper( pin1,pin2,pin3,pin4);
    stepper->setRpm(10);
    stepper->setTotalSteps(4096);
    dir = invDirection;
    
  }
  void Motor::moveTo(boolean cw,int steps)
  {
//    Serial.println(stepper->getStepsLeft());
    if(stepper->getStepsLeft()<=0)
    {
        currentSteps +=((cw)?-1:1)*steps;
//        Serial.print("steps:");
//        Serial.println(currentSteps);
        
        for(int i=0;i<steps;i++)
        {
          stepper->step((cw)?dir:!dir);
        }
    }
  }
  void Motor::moveAt(float lerpValue)
  {
    workingSteps = mapfloat(lerpValue,0,1.0,startingSteps,targetSteps);
    magnitudeSteps = currentSteps-workingSteps;
    for(index=0;index<abs(magnitudeSteps);index++)
    {
      stepper->step((magnitudeSteps<0)?dir:!dir);
    }
    currentSteps -=magnitudeSteps;
    
    
  }
  float Motor::mapfloat(float x, float in_min, float in_max, float out_min, float out_max)
  {
   return (float)(x - in_min) * (out_max - out_min) / (float)(in_max - in_min) + out_min;
  }
  void Motor::setTarget(int newTargetSteps)
  {
    startingSteps = currentSteps;
    totalTravel = targetSteps - currentSteps;
    targetSteps = newTargetSteps;
  }
  void Motor::update()
  {
    //stepper->run();
  }
  int Motor::getSteps()
  { 
    return currentSteps;
  }
  void Motor::calibrate(int initStep)
  {
    currentSteps = initStep;
  }
};

