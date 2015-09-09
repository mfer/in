#!/bin/bash
git clone https://github.com/wendley/gr-ieee802-15-4.git
cd gr-ieee802-15-4/
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig
