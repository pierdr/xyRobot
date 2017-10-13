#define M1_ZERO_STEP 1265
#define M2_ZERO_STEP 1265

#define HALF_L 550          
#define FRAME_ORIGIN_X 320  
#define FRAME_ORIGIN_Y 30 

#define MM_TO_STEPS 2.37 //9.3

class MotorsManager
{
    Motor *lm;
    Motor *rm;

    int positionLm,positionRm;
    public:
    MotorsManager::MotorsManager(){
      
    }

    void MotorsManager::addLeftMotor(int pin1, int pin2, int pin3, int pin4)
    {
       lm = new Motor(pin1,pin2,pin3,pin4);
        
    }
    
    void MotorsManager::addRightMotor(int pin1, int pin2, int pin3, int pin4)
    {
       rm = new Motor(pin1,pin2,pin3,pin4); 
       
    }
    void MotorsManager::testMotors()
    {
      rm->moveTo(true, 4096);
      lm->moveTo(true, 4096);
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
//#define M1_ZERO_STEP 4550
//#define M2_ZERO_STEP 4550
//
//#define HALF_L 550          
//#define FRAME_ORIGIN_X 320  
//#define FRAME_ORIGIN_Y 30 
//
//#define MM_TO_STEPS 9.3
      positionLm=(sqrt(sq(HALF_L+(x-FRAME_ORIGIN_X))+sq(y+FRAME_ORIGIN_Y)))*MM_TO_STEPS;   
      positionRm=(sqrt(sq(HALF_L-(x-FRAME_ORIGIN_X))+sq(y+FRAME_ORIGIN_Y)))*MM_TO_STEPS;
      Serial.print("steps:");
      Serial.print(positionLm);
      Serial.print(" ");
      Serial.println(positionRm);
      lm->moveTo((lm->getSteps()>positionLm)?true:false,positionLm);
      rm->moveTo((rm->getSteps()>positionRm)?false:true,positionRm);
      Serial.print("L-");   
          

    }
    void MotorsManager::calibrate()
    {
       lm->calibrate(M1_ZERO_STEP);
       rm->calibrate(M2_ZERO_STEP);
    }
    
};

