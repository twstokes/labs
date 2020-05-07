## Bluetooth LE Zoom Muter

A physical button to mute Zoom on iPad OS.

<https://www.tannr.com/2020/04/10/ipad-zoom-mute-button/>

![alt text](media/zoom_mute.gif "Pressing a button to turn a page on an iPad")

### Hardware
- [Adafruit BLE ATmega32u4](https://www.adafruit.com/product/2661) or [Adafruit Feather 32u4 BLE](https://www.adafruit.com/product/2829)
- iPad with Zoom installed
- A button
- 10k ohm resistor to prevent floating input

### How it works
1. Connect up a button to the MCU. This code uses pin A0 for digital input, defined by `BUTTON_PIN`. [Here's an example.](https://www.arduino.cc/en/tutorial/button)
1. Pair the button using Bluetooth settings
1. Tell iPad OS to remap Caps Lock to Command (General -> Hardware Keyboard -> Modifier Keys)
1. Load up Zoom
1. Hit the button!

### Why it works

Since the BLE device acts as a keyboard, it's simply hitting shift + caps lock + a. [See keycodes here.](https://learn.adafruit.com/introducing-adafruit-ble-bluetooth-low-energy-friend/ble-services#at-plus-blekeyboardcode-14-25)

### Building

1. Install [PlatformIO](https://platformio.org/)
1. Connect the MCU and run `pio run -t upload`


### Monitoring

`pio device monitor`

### Gotchas

- Monitor the serial output to make sure things are OK
- If Bluetooth starts acting flaky, reset the microcontroller using the [Adafruit reset example](https://github.com/adafruit/Adafruit_BluefruitLE_nRF51/tree/master/examples/factoryreset).

