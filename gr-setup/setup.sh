#!/bin/bash
cd ~
wget http://www.sbrac.org/files/build-gnuradio && chmod a+x ./build-gnuradio && ./build-gnuradio

git clone https://github.com/bastibl/gr-foo.git
cd gr-foo
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig

cd ../..

git clone https://github.com/wendley/gr-ieee802-15-4.git
cd gr-ieee802-15-4/
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig

##after connect the device test it with
#uhd_find_devices
##to install missing firmwares
#sudo python "/usr/lib/uhd/utils/uhd_images_downloader.py"
