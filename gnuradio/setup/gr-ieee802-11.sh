#!/bin/bash
sudo apt-get install -y liblog4cpp5-dev libitpp-dev python-opengl
sudo sysctl -w kernel.shmmax=2147483648

./bastibl-gr-foo.sh

git clone https://github.com/bastibl/gr-ieee802-11.git
cd gr-ieee802-11
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig
