#include <SoftwareSerial.h>
#include <Servo.h>

SoftwareSerial scaleSerial(8, 9); // RX | TX
SoftwareSerial BTSerial(10, 11); // RX | TX

Servo myservo;  // create servo object to control a servo
int pos = 0;    // variable to store the servo position


float  animalWeight;
String weightString = "";
char   BTArray[5];

float  servingSize;
String servingString = "";

void setup()
{
  //pinMode(9, OUTPUT);  // this pin will pull the HC-05 pin 34 (key pin) HIGH to switch module to AT mode
  //digitalWrite(9, HIGH);
  Serial.begin(9600);
  Serial.println("Enter AT commands:");
  BTSerial.begin(9600);
  scaleSerial.begin(9600);  // HC-05 default speed in AT command more

  // tare scale... check if scaleSerial rdy?
  while(!scaleSerial);
  scaleSerial.println("x");
  scaleSerial.println("1");
  scaleSerial.println("2");
  delay(1000);

  // Servo to pin
  myservo.attach(5);  // attaches the servo on pin 9 to the servo object
  pinMode(13, OUTPUT);
  digitalWrite(13, HIGH);
  
  pinMode(12, OUTPUT);
  digitalWrite(12, HIGH);

    myservo.write(90);
    delay(1000);
    myservo.write(180);
    delay(3000);
    myservo.write(90);
    //while(1);
}

void loop()
{
  char c;
//  if (Serial.available())
//  {
//    c = Serial.read();
//    scaleSerial.print(c);
//  }

/***************** SCALE *****************/

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

      // Send weight
      weightString.toCharArray(BTArray, 4);
      BTArray[4] = '\0';
      BTSerial.write(BTArray);
      
      weightString = "";
    }
    //Serial.print(c);
  }

/***************** BTOOTH *****************/
  // Read Stuff!!!
  if (BTSerial.available())
  {
    Serial.print("TESTING");
    for (int i = 0; i < 6; i++)
      {
        while(!BTSerial.available());
        c = BTSerial.read();
        servingString += c;
      }
      servingSize = servingString.toFloat();
      Serial.print("SERVING SIZE");
      Serial.println(servingSize);
  }

/***************** SERVO *****************/
  if (Serial.available())
  {
    c = 'p';//Serial.read();
    if (c == 'x')
    {
      for (pos = 0; pos <= 90; pos += 1) { // goes from 0 degrees to 180 degrees
        // in steps of 1 degree
        myservo.write(pos);              // tell servo to go to position in variable 'pos'
        delay(30);                       // waits 15ms for the servo to reach the position
      }
      for (pos = 90; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
        myservo.write(pos);              // tell servo to go to position in variable 'pos'
        delay(30);                       // waits 15ms for the servo to reach the position
      }
    }
  }

  //myservo.write(0);
  //delay(1000);
  //myservo.write(90);
  
}


