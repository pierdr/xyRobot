 //550*MM_TO_STEPS

#define HALF_L          535 //550 (white robot)          
#define FRAME_ORIGIN_X  320 //320 (white robot)  
#define FRAME_ORIGIN_Y  270 //330 (white robot)

#define MM_TO_STEPS 27.3//codame robot 71.4285714(steps/mm ) //(white robot on the window) 25 // previous9.3 -- 

#define L_ZERO_STEP 600*MM_TO_STEPS//645*MM_TO_STEPS (white robot)
#define R_ZERO_STEP 600*MM_TO_STEPS//690*MM_TO_STEPS (white robot)

#define INIT -1
#define DRAW 0
#define IDLE 1




class MotorsManager
{
    Motor *lm;
    Motor *rm;

    int lCurrentSteps;
    int rCurrentSteps;

    int lTargetSteps;
    int rTargetSteps;
    int state = INIT;

//    int rWorkingSteps;
//    int lWorkingSteps;

    float lerpValue = 0.0;    
    
    //int positionLm,positionRm;
    
    public:
    MotorsManager::MotorsManager(){
      
    }

    void MotorsManager::addLeftMotor(int pin1, int pin2, int pin3, int pin4,boolean invDirection)
    {
       lm = new Motor(pin1,pin2,pin3,pin4,invDirection);
        
    }
    
    void MotorsManager::addRightMotor(int pin1, int pin2, int pin3, int pin4,boolean invDirection)
    {
       rm = new Motor(pin1,pin2,pin3,pin4,invDirection); 
       
    }
    void MotorsManager::testMotors()
    {
      rm->moveTo(true, 4096);
      lm->moveTo(true, 4096);
    }
    void MotorsManager::reset()
    {
      lm->setTarget(L_ZERO_STEP);
      rm->setTarget(R_ZERO_STEP);
      changeState(DRAW);
    }
    void MotorsManager::moveLeftMotor(boolean ccw,int steps)
    {
        lm->moveTo(ccw,steps); 
    }
    void MotorsManager::moveRightMotor(boolean ccw,int steps)
    {
        rm->moveTo(ccw,steps); 
    }
    void MotorsManager::update(){
      if(state==DRAW)
      {   
           //determine next steps
            lerpValue+=0.0006;//was 0.005
            if(lerpValue>=1.0)
            {
              lerpValue = 1.0;
            }
           
            lm->moveAt(lerpValue);
            

            rm->moveAt(lerpValue);

            if(lerpValue == 1.0)
            {
              changeState(IDLE);
            }
        
      }
      rm->update();
      lm->update();
    }
    void MotorsManager::print(){
      Serial.print(lm->getSteps());
      Serial.print(",");
      Serial.print(rm->getSteps());
      Serial.println(" ");
    }
    void MotorsManager::moveTo(float x,float y)
    {
      if(state!=DRAW)
      {
        lTargetSteps=(sqrt(sq(HALF_L+(x-FRAME_ORIGIN_X))+sq(y+FRAME_ORIGIN_Y)))*MM_TO_STEPS;   
        rTargetSteps=(sqrt(sq(HALF_L-(x-FRAME_ORIGIN_X))+sq(y+FRAME_ORIGIN_Y)))*MM_TO_STEPS;
//        lTotalTravelSteps = lTargetSteps - lCurrentSteps;
//        rTotalTravelSteps = rTargetSteps - rCurrentSteps;
        lm->setTarget(lTargetSteps);
        rm->setTarget(rTargetSteps);
        
        lerpValue = 0.0;
        
        //lm->movprintlneTo((lm->getSteps()>positionLm)?true:false,positionLm);
        //rm->moveTo((rm->getSteps()>positionRm)?false:true,positionRm);
        changeState(DRAW);
      }
    }
    void MotorsManager::calibrate()
    {
       lm->calibrate(L_ZERO_STEP);
       rm->calibrate(R_ZERO_STEP);
    }
    void MotorsManager::changeState(int newState)
    {
        switch(newState) 
        {
          case IDLE:
            if(state == DRAW){
              //NOTIFY STOPPED
              Serial.print("L-");
            }
          break;
          case DRAW:
          break;
          case INIT:
          break;
        }
        state = newState;
    }
};

