#include <SoftwareSerial.h>

SoftwareSerial scaleSerial(5, 6); // RX | TX
SoftwareSerial BTSerial(10, 11); // RX | TX


float  animalWeight;
String weightString = "";

void setup()
{
  //pinMode(9, OUTPUT);  // this pin will pull the HC-05 pin 34 (key pin) HIGH to switch module to AT mode
  //digitalWrite(9, HIGH);
  Serial.begin(9600);
  Serial.println("Enter AT commands:");
  scaleSerial.begin(9600);  // HC-05 default speed in AT command more

  // tare scale... check if scaleSerial rdy?
  while(!scaleSerial);
  scaleSerial.println("x");
  scaleSerial.println("1");
  scaleSerial.println("2");
  delay(1000);
}

void loop()
{
  char c;
//  if (Serial.available())
//  {
//    c = Serial.read();
//    scaleSerial.print(c);
//  }

  if (scaleSerial.available())
  {
    c = scaleSerial.read();
    if ( c == '[' )
    {
      for (int i = 0; i < 4; i++)
      {
        while(!scaleSerial.available());
        c = scaleSerial.read();
        weightString += c;
      }
      weightString += '\n';
      Serial.print(weightString);
      
      animalWeight = weightString.toFloat();
      Serial.println(animalWeight);
      weightString = "";
    }
    //Serial.print(c);
  }
}

