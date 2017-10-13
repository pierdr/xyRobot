String inputString;

void serialEvent() {
  while (arduino.available()>0) {
    // get the new byte:
    
    char inChar = (char)arduino.read();
    // add it to the inputString:
    inputString += inChar;
    // if the incoming character is a newline, set a flag so the main loop can
    // do something about it:
    if (inChar == '-' || inChar=='\n') {
        println(inputString);
        inputString = "";
    }
  }
}