#define HALFSTEP 8
class Motor{
  CheapStepper *stepper;
  int currentSteps = 0;

  public:
  Motor::Motor(int pin1,int pin2, int pin3, int pin4)
  {
    stepper = new CheapStepper( pin1,pin2,pin3,pin4);
    stepper->setRpm(10);
    stepper->setTotalSteps(1024);
    
  }
  void Motor::moveTo(boolean cw,int steps)
  {

//    if (stepper->distanceToGo() == 0) {
//      stepper->moveTo(((cw)?-1:1)*steps);
//    }
    Serial.println(stepper->getStepsLeft());
    if(stepper->getStepsLeft()<=0)
    {
        currentSteps +=((cw)?-1:1)*steps;
        Serial.print("steps:");
        Serial.println(currentSteps);
        stepper->moveTo(cw, currentSteps);
    }
  }
  void Motor::update()
  {
    stepper->run();
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

