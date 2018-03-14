Tramontana cameraRemote;
Tramontana robotHead;
final static int RELAY_NUM = 1;

void initTramotana()
{
  cameraRemote = new Tramontana(this,"192.168.1.10");
  robotHead = new Tramontana(this,"192.168.1.11");
  cameraRemote.setRelayEmbedded(RELAY_NUM,1);
  
}