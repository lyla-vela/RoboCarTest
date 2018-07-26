//www.elegoo.com
//2016.09.19 
// Author: Lyla Vela
// Use HC-08 Bluetooth module for scanner to find your device
// If you are Using a Kookye robot tank, use a different device than the wifi-board, and update the pins as below 

int LED=13;
volatile int state = LOW;
char getstr;
int in1=8;
int in2=9;
int in3=10;
int in4=12;
int ENA=5;
int ENB=6;
int ABS=150;
void _mForward()
{ 
  digitalWrite(ENA,HIGH);
  digitalWrite(ENB,HIGH);
  digitalWrite(in1,HIGH);//digital output
  digitalWrite(in2,LOW);
  digitalWrite(in3,LOW);
  digitalWrite(in4,HIGH);
  Serial.println("Forward");
}
void _mBack()
{
  digitalWrite(ENA,HIGH);
  digitalWrite(ENB,HIGH);
  digitalWrite(in1,LOW);
  digitalWrite(in2,HIGH);
  digitalWrite(in3,HIGH);
  digitalWrite(in4,LOW);
  Serial.println("Back");
}
void _mleft()
{
//  analogWrite(ENA,ABS);
//  analogWrite(ENB,ABS);
  digitalWrite(ENA,HIGH);
  digitalWrite(ENB,HIGH);
  digitalWrite(in1,HIGH);
  digitalWrite(in2,LOW);
  digitalWrite(in3,HIGH);
  digitalWrite(in4,LOW); 
  Serial.println("go left!");
}
void _mright()
{
//  analogWrite(ENA,ABS);
//  analogWrite(ENB,ABS);
  digitalWrite(ENA,HIGH);
  digitalWrite(ENB,HIGH);
  digitalWrite(in1,LOW);
  digitalWrite(in2,HIGH);
  digitalWrite(in3,LOW);
  digitalWrite(in4,HIGH);
  Serial.println("go right!");
}
void _mStop()
{
  digitalWrite(ENA,LOW);
  digitalWrite(ENB,LOW);
  Serial.println("Stop!");
}
void stateChange()
{
  state = !state;
  digitalWrite(LED, state);  
}
void setup()
{ 
  pinMode(LED, OUTPUT);
  Serial.begin(9600);
  pinMode(in1,OUTPUT);
  pinMode(in2,OUTPUT);
  pinMode(in3,OUTPUT);
  pinMode(in4,OUTPUT);
  pinMode(ENA,OUTPUT);
  pinMode(ENB,OUTPUT);
  _mStop();
}
void loop()
  { 
  getstr=Serial.read();
 if(getstr=='f')
  {
    _mForward();
  }
  else if(getstr=='b')
  {
    _mBack();
    delay(200);
  }
  else if(getstr=='l')
  {
    _mleft();
    delay(200);
  }
  else if(getstr=='r')
  {
    _mright();
    delay(200);
  }
  else if(getstr=='s')
  {
     _mStop();     
  }
  else if(getstr=='A')
  {
  stateChange();
  }
}

