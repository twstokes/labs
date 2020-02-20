## Bluetooth LE Page Turner

This is a prototype to show how someone could make a remote Bluetooth page turning device using a Bluetooth LE controller that acts as a keyboard.

![alt text](media/page_turner.gif "Pressing a button to turn a page on an iPad")

### Hardware
- [Adafruit BLE ATmega32u4](https://www.adafruit.com/product/2661) or [Adafruit Feather 32u4 BLE](https://www.adafruit.com/product/2829)
- Operating system and hardware capable of connecting to BLE HID devices (e.g. iPad)
- A button
- 10k ohm resistor to prevent floating input

### How it works
1. Connect up a button to the MCU. This code uses pin 12 for digital input, defined by `BUTTON_PIN`. [Here's an example.](https://www.arduino.cc/en/tutorial/button)
1. Pair the device using Bluetooth settings
1. Load an app that (e.g. Books on iOS) that views eBooks or PDFs
1. Hit the button!

### Why it works

Since the BLE device acts as a keyboard, it's simply hitting the "right arrow" key by sending the code: `00-00-4F` and then `00-00`. [See keycodes here.](https://learn.adafruit.com/introducing-adafruit-ble-bluetooth-low-energy-friend/ble-services#at-plus-blekeyboardcode-14-25)

### Building

1. Install [PlatformIO](https://platformio.org/)
1. Connect the MCU and run `pio run -t upload`


### Monitoring

`pio device monitor`

### Gotchas

- Monitor the serial output to make sure things are OK
- If Bluetooth starts acting flaky, reset the microcontroller using the [Adafruit reset example](https://github.com/adafruit/Adafruit_BluefruitLE_nRF51/tree/master/examples/factoryreset).

