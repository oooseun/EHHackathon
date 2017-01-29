#include <SoftwareSerial.h>

SoftwareSerial BTSerial(10, 11); // RX | TX

void setup()
{
  pinMode(9, OUTPUT);  // this pin will pull the HC-05 pin 34 (key pin) HIGH to switch module to AT mode
  digitalWrite(9, HIGH);
  Serial.begin(9600);
  Serial.println("Enter AT commands:");
  BTSerial.begin(9600);  // HC-05 default speed in AT command more

  // tare scale... check if BTSerial rdy?
  while(!BTSerial);
  BTSerial.println("x");
  BTSerial.println("1");
  BTSerial.println("2");
}

void loop()
{
  char c;
  if (Serial.available()) {
    c = Serial.read();
    BTSerial.print(c);
  }
  if (BTSerial.available()) {
    c = BTSerial.read();
    Serial.print(c);    
  }
}
