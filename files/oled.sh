#!/bin/bash
[ -h /usr/bin/ccache_cc ] || ln -s /usr/bin/gcc /usr/bin/ccache_cc
mkdir -p /rpi

cd /rpi
if [ ! -d RPi.GPIO-0.6.3 ] ; then
  wget https://files.pythonhosted.org/packages/e2/58/6e1b775606da6439fa3fd1550e7f714ac62aa75e162eed29dbec684ecb3e/RPi.GPIO-0.6.3.tar.gz
  tar xzf RPi.GPIO-0.6.3.tar.gz
fi
cd RPi.GPIO-0.6.3
if [ ! -f  /usr/lib/python2.7/site-packages/RPi.GPIO-0.6.3-py2.7.egg-info ]; then
  python setup.py install
fi

cd /rpi
if [ ! -d Imaging-1.1.7 ] ; then
  wget http://effbot.org/downloads/Imaging-1.1.7.tar.gz
  tar xzf Imaging-1.1.7.tar.gz
fi
cd Imaging-1.1.7
if [ ! -f /usr/lib/python2.7/site-packages/PIL/PIL-1.1.7-py2.7.egg-info ]; then
  python setup.py install
fi

cd /rpi
if [ ! -d Adafruit_Python_SSD1306 ]; then
  git clone https://github.com/adafruit/Adafruit_Python_SSD1306.git
fi
cd Adafruit_Python_SSD1306
if [ ! -f /usr/lib/python2.7/site-packages/Adafruit_PureIO-0.2.3-py2.7.egg ]; then
  python setup.py install
fi

