int voltpin = 0; // A0 for battery voltage

float voltAverageRaw; // Value for average voltage
float voltAverage; // Calculated value for average voltage
float VOLTLOW = 10; // Low voltage

int redled = 12;
int greenled = 13;

int driveleftpwmpin = 9;
int driveleft0pin = 6;
int driveleft1pin = 5;

int driverightpwmpin = 10;
int driveright0pin = 8;
int driveright1pin = 7;

int driveleftspeed = 0; // 160; // 255;
int driverightspeed = 0; // 160; // 255;


int brushpin = 11;
int brushSpeed = 0; //; // Max 255

int greenLight = 1;
int redLight = 1;

void setup() {
  Serial.begin(57600);

  pinMode(driveleft0pin, OUTPUT);
  pinMode(driveleft1pin, OUTPUT);
  pinMode(driveright0pin, OUTPUT);
  pinMode(driveright1pin, OUTPUT);

  pinMode(redled, OUTPUT);
  pinMode(greenled, OUTPUT);
  digitalWrite(redled, HIGH);
  
  voltAverageRaw = analogRead(voltpin);
  voltAverage = voltAverageRaw * 5.0 / 1023 * 26.7 / 4.7; // is factor for voltagedevider 22K / 4,7K

}

bool isStopped() {
  if (voltAverage < VOLTLOW) {
    Serial.print("STOPPED: ");
    Serial.println(voltAverage);
    return true;
  }
  
  float voltRaw = analogRead(voltpin);
  voltAverageRaw = 0.9 * voltAverageRaw + 0.1 * voltRaw;
  Serial.print("Raw volt value: ");
  Serial.println(voltRaw);
  Serial.print("Average raw volt value: ");
  Serial.println(voltAverageRaw);
  voltAverage = voltAverageRaw * 5.0 / 1023 * 26.7 / 4.7; // is factor for voltagedevider 22K / 4,7K
  
  Serial.print("Calculated volt value: ");
  Serial.println(voltAverage);
  Serial.println("");
  return false;
}

void drive()  {
  if (driveleftspeed > 0) {
    digitalWrite(driveleft0pin, LOW);
    digitalWrite(driveleft1pin, HIGH);
    analogWrite(driveleftpwmpin, driveleftspeed);
  } else {
    digitalWrite(driveleft0pin, HIGH);
    digitalWrite(driveleft1pin, LOW);
    analogWrite(driveleftpwmpin, -1 * driveleftspeed);
  }

  if (driverightspeed > 0) {
    digitalWrite(driveright0pin, LOW);
    digitalWrite(driveright1pin, HIGH);
    analogWrite(driverightpwmpin, driverightspeed);
  } else {
    
    digitalWrite(driveright0pin, HIGH);
    digitalWrite(driveright1pin, LOW);
    analogWrite(driverightpwmpin, -1 * driverightspeed);
  }
}

bool readFromSerial() {
  if (Serial.available() > 0) {
    String data = Serial.readStringUntil('\n');
    Serial.print("You sent me: ");
    Serial.println(data);
    int firstSpace = data.indexOf(' ');
    int left = data.substring(0, firstSpace).toInt();
    int secondSpace = data.indexOf(' ', firstSpace + 1);
    int right = data.substring(firstSpace + 1, secondSpace).toInt();
    int thirdSpace = data.indexOf(' ', secondSpace + 1);
    int brush = data.substring(secondSpace + 1, thirdSpace).toInt();
    int fourthSpace = data.indexOf(' ', thirdSpace + 1);
    int green = data.substring(thirdSpace + 1, fourthSpace).toInt();
    int red = data.substring(fourthSpace + 1).toInt();
    
    driveleftspeed = min(left, 220);
    driverightspeed = min(right, 220);
    brushSpeed = min(brush, 200);
    greenLight = min(green, 1);
    redLight = min(red, 1);
    return true;
  }
  return false;
}

void loop() {
  if (isStopped()) {
    readFromSerial();
    delay(1000);
    return;
  }

  if (readFromSerial()) {
    drive();
    analogWrite(brushpin, brushSpeed);
    digitalWrite(redled, redLight == 1 ? HIGH : LOW);
    digitalWrite(greenled, greenLight == 1 ? HIGH : LOW);
  }
}
