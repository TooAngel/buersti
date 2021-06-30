from evdev import InputDevice, InputEvent
import math
import serial
import time
import threading
import os
import sys
import logging
import logging.handlers

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

handler = logging.handlers.SysLogHandler(address='/dev/log')
handler.setLevel(logging.DEBUG)
logger.addHandler(handler)

consoleHandler = logging.StreamHandler(sys.stdout)
consoleHandler.setLevel(logging.DEBUG)
logger.addHandler(consoleHandler)

pid = str(os.getpid())
f = open('gamecontroller.pid', 'w')
f.write(pid)
f.close()

class Controller(threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)
        self.values = {
            'left': 0,
            'right': 0,
            'brush': 0,
            'green': 1,
            'red': 1,
        }
        self.running = True
    
    def setValue(self, key, value):
        if self.values[key] != value:
            self.values[key] = value
            toSend = '{} {} {} {} {}'.format(
                self.values['left'],
                self.values['right'],
                self.values['brush'],
                self.values['green'],
                self.values['red'])
            logger.info('Sending: {}'.format(toSend))
            self.arduino.write('{}\n'.format(toSend))

    def run(self):
        # TODO get the correct device
        self.gamepad = InputDevice('/dev/input/event2')
        
        left_code = 1
        right_code = 4
        brush_code = 5
        green = 304
        red = 305

        max_value = 32687.
        max_brush_value = 255.

        for event in self.gamepad.read_loop():
            if not self.running:
                return

            if event.code == 0:
                continue # Skip for some reason, not sure what it is

            if event.code == left_code:
                self.setValue('left', int(math.floor(-1 * event.value / max_value * 200)))
                continue

            if event.code == right_code:
                self.setValue('right', int(math.floor(-1 * event.value / max_value * 200)))
                continue
            
            if event.code == brush_code:
                self.setValue('brush', int(math.floor(event.value / max_brush_value * 200)))
                continue
            
            if event.code == green:
                if event.value == 1:
                    self.setValue('green', int(not self.values['green']))
                continue

            if event.code == red:
                if event.value == 1:
                    self.setValue('red', int(not self.values['red']))
                continue

            logger.info(event)

class Reader(threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)
        self.running = True

    def run(self):
         while self.running:
            line = self.arduino.readline().decode('utf-8').rstrip()
            logger.info(line)

def main():
    controller = Controller()
    reader = Reader()
    try:
        arduino = serial.Serial('/dev/ttyACM0', 57600, timeout=1)
        controller.arduino = arduino
        controller.start()
        reader.arduino = arduino
        reader.start()

        while True:
            time.sleep(1)

    except KeyboardInterrupt:
        logger.info('KeyboardInterrupt')
        controller.running = False
        # controller.gamepad.write_event(InputEvent(0, 0, 0, 0, 0))
        reader.running = False


if __name__ == '__main__':
    main()