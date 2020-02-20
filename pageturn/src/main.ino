#include <Arduino.h>
#include <SPI.h>
#include "Adafruit_BLE.h"
#include "Adafruit_BluefruitLE_SPI.h"
#include "Adafruit_BluefruitLE_UART.h"

#include "BluefruitConfig.h"

#if SOFTWARE_SERIAL_AVAILABLE
  #include <SoftwareSerial.h>
#endif

#define MINIMUM_FIRMWARE_VERSION    "0.6.6"
#define BUTTON_PIN 12

Adafruit_BluefruitLE_SPI ble(BLUEFRUIT_SPI_CS, BLUEFRUIT_SPI_IRQ, BLUEFRUIT_SPI_RST);

// A small helper
void error(const __FlashStringHelper*err) {
  while (1);
}

void setup(void)
{
  while (!Serial);
  delay(500);

  pinMode(BUTTON_PIN, INPUT);

  Serial.begin(115200);

  if ( !ble.begin(true) )
  {
    error(F("Couldn't find Bluefruit, make sure it's in CoMmanD mode & check wiring?"));
  }

  ble.echo(true);

  if (! ble.sendCommandCheckOK(F( "AT+GAPDEVNAME=Bluefruit Keyboard" )) ) {
    error(F("Could not set device name?"));
  }

  if ( ble.isVersionAtLeast(MINIMUM_FIRMWARE_VERSION) )
  {
    if ( !ble.sendCommandCheckOK(F( "AT+BleHIDEn=On" ))) {
      error(F("Could not enable Keyboard"));
    }
  } else
  {
    if (! ble.sendCommandCheckOK(F( "AT+BleKeyboardEn=On"  ))) {
      error(F("Could not enable Keyboard"));
    }
  }

  /* Add or remove service requires a reset */
  Serial.println(F("Performing a SW reset (service changes require a reset): "));
  if (! ble.reset() ) {
    error(F("Couldn't reset??"));
  }

  Serial.println("Ready");
}

void loop(void)
{
  if(digitalRead(BUTTON_PIN)) {
      Serial.println("BUTTON PRESSED");

    // send the keyboard code command for right arrow
    ble.println("AT+BleKeyboardCode=00-00-4F");
    ble.println("AT+BleKeyboardCode=00-00");

    if( ble.waitForOK() )
    {
        Serial.println( F("OK!") );
    }else
    {
        Serial.println( F("FAILED!") );
    }

      delay(500);
  }

  delay(10);
}
