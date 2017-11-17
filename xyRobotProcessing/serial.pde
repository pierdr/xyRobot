




class controller{
  boolean isSimulated;
  Serial arduino;
  Tramontana cameraRemote;
  Tramontana robotHead;
  
  String inputString;
  
  
  controller(boolean isSimulated,PApplet parent)
  {
    this.isSimulated = isSimulated;
    if(!this.isSimulated)
    {
      String portName = Serial.list()[1];
      arduino = new Serial(parent, portName, 115200);
      cameraRemote = new Tramontana(parent,"192.168.1.17");
      robotHead = new Tramontana(parent,"192.168.1.18");
      cameraRemote.setRelayEmbedded(RELAY_NUM,1);
      
      
    }
  }
  controller(PApplet parent)
  {
    this(false,parent);
  }
  
  void serialEvent() {
    if(!isSimulated)
    {
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
}
  
  
  


}