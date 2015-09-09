#!/bin/bash
wget http://www.sbrac.org/files/build-gnuradio && chmod a+x ./build-gnuradio && ./build-gnuradio

##after connect the device test it with
#uhd_find_devices
##to install missing firmwares
#sudo python "/usr/lib/uhd/utils/uhd_images_downloader.py"
