String inputString;

void initSerial()
{
  String portName = Serial.list()[2];
  //println(Serial.list());
  arduino = new Serial(this, portName, 115200);
}
void serialEvent() {
  while (arduino.available()>0) {
    // get the new byte:
    
    char inChar = (char)arduino.read();
    // add it to the inputString:
    
    // if the incoming character is a newline, set a flag so the main loop can
    // do something about it:
    if (inChar == '-' || inChar=='\n') {
        println("::"+inputString+"::");
        if(inputString.equals("L"))
        {
          println("going to point");
          arrivedToPoint();
        }
        inputString = "";
    }
    else
    {
      inputString += inChar;
    }
  }
}