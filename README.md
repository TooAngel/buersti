# Buersti

Have a look at https://emanual.robotis.com/docs/en/platform/turtlebot3/overview/

## Circuit

- Resistor before LED: Reduce current (https://www.build-electronic-circuits.com/resistor-before-or-after-led/)
- Capacitor at power supply: Preventing voltage spikes?
  - The power supply consists of the electrolytic
capacitor C1 that smoothes the supply voltage (which is very important because the 3 DC motors are
all operated with PWM) 
  - (https://www.quora.com/Capacitors-block-DC-voltage-Why-they-are-used-in-DC-circuits?share=1)
- voltage divider
  - https://en.wikipedia.org/wiki/Voltage_divider


## TODO

- motor holder positions wrong
- motor screws wrong
- thread holes to big (wheel_connector)
- wheels have a bad tracktion
- the chassis should be thicker
- better brush
- brush motor faster
- remove arduino, rapsberry pi should be enough

## To buy

- Akku connector
- m3 nuts
- 2er schraubdinger
- 3er schraubdinger
- 12Vto5V raspberry pi & lidar wandler
- usb FTDI-Adapter for lidar
- Schalter
- gummi Abstandshalter
- m3 nuts?

## Motor driver

- https://components101.com/modules/l293n-motor-driver-module
- https://www.electronicshub.org/raspberry-pi-l298n-interface-tutorial-control-dc-motor-l298n-raspberry-pi/

## LIDAR

- http://www.core-tec.co.uk/BadPidea/uncategorized/lidar-on-the-cheap-using-the-hls-lfcd2-pt2/
- https://mein-roboter.blogspot.com/2020/01/lidar-loppt_15.html
- http://wiki.ros.org/hls_lfcd_lds_driver
- https://emanual.robotis.com/assets/docs/LDS_Basic_Specification.pdf

## Raspberry PI setup

- Install python
- Install evdev and serial

### Motors

- https://www.conrad.de/de/p/modelcraft-rb350200-0a101r-getriebemotor-12-v-1-200-227579.html?searchType=SearchRedirect

Maybe this?
https://www.conrad.de/de/p/motraxx-gleichstrommotor-sr555shp-3247s-75-sr555shp-3247s-75-12-0-v-dc-1-463-a-25-18-nmm-5028-u-min-wellen-durchmesser-1711504.html#productTechData
or this?
https://www.amazon.com/PLUMIA-Eccentric-Diameter-Electric-Reduction/dp/B08YR9WZ26/ref=sr_1_12?dchild=1&keywords=12v+dc+motor&qid=1625477025&sr=8-12

Copy init script sudo cp /home/pi/gamecontroller /etc/init.d
Register script sudo update-rc.d gamecontroller defaults

## How to set it up

- Plug stuff together
- deploy arduino files to the arduino
- copy gamecontroller.py to raspberry pi
- use the init script somehow on the raspberry pi

### Inspired by

http://reprap-windturbine.com/index.php?id=20&L=1