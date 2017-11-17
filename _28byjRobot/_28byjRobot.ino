
//--------------------------------------------------------------------------
//ACCELERATION LIB AND STEPPER SETUP
//--------------------------------------------------------------------------
// two stepper motors one on each port
#include <CheapStepper.h>
#include "Motor.h"
#include "MotorsManager.h"

MotorsManager mm;



//CheapStepper stepper1 (8,9,10,11);  
//CheapStepper stepper2 (4,5,6,7);

bool moveClockwise = false;
unsigned long moveStartTime = 0;

//CheapStepper stepper = stepper1;

//*** STATE MACHINE ***//
#define INIT          0
#define IDLE          1
#define MOVING        2
#define DRAW_ELLIPSE  3

int state=INIT;

//--------------------------------------------------------------------------
//COMMUNICATION & LOGIC
//--------------------------------------------------------------------------
String inputString,workingString;
int workingX,workingY;
boolean stringComplete=false;

const char delimiter[2] = ",";
char * workingCstr;
char inChar;

unsigned long eventTime = 0;

//--------------------------------------------------------------------------
//DRAW
//--------------------------------------------------------------------------
float lerpValue=0;
float cX=0,cY=0,rX=0,rY=0;

//--------------------------------------------------------------------------
//UTILS
//--------------------------------------------------------------------------
#define DEBUG 0

void setup() {
    Serial.begin(115200);
    mm.addLeftMotor(8,9,10,11,false);
    mm.addRightMotor(4,5,6,7,true);
}


void loop() {
  updateCommands();
  mm.update();
}
