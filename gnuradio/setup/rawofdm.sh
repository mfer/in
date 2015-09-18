#!/bin/bash
#http://people.csail.mit.edu/szym/rawofdm/
wget -c http://people.csail.mit.edu/szym/rawofdm/rawofdm.tgz
tar xvzf rawofdm.tgz

cd rawofdm

wget -c ftp://ftp.gnu.org/gnu/gnuradio/gr-howto-write-a-block-3.3.0.tar.gz
tar -vzxf gr-howto-write-a-block-3.3.0.tar.gz

./makelinks.sh gr-howto-write-a-block-3.3.0/
./bootstrap

#falhou por conta de pacote gnuradio-core ter virado gnuradio-runtime
#http://nuand.com/forums/viewtopic.php?t=3137
#before error:  pkg-config --modversion gnuradio-core
git clone https://github.com/guruofquality/grcompat.git grcompat
cd grcompat
cmake ./
make
sudo make install
#returns space after: pkg-config --modversion gnuradio-core

cat configure | sed 's/gnuradio-core >= 3/gnuradio-core/' > configure_mod
sed -i 's/gruel >= 3/gruel/' configure_mod
sudo chmod +x configure_mod
./configure_mod --prefix $HOME  #uggly fix

make check
#not find gr_expj.h now it is "/usr/local/include/gnuradio/expj.h"
#not find gr_crc32.h now it is "/usr/local/include/gnuradio/digital/crc32.h/usr/local/include/gnuradio/digital/crc32.h"
#     plus gr_crc32(.) chaged to gr::digital::crc32(.)

&& sudo make install
