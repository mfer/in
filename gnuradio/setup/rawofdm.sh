#!/bin/bash
#installing gnuradio3.3
wget -c http://gnuradio.org/releases/gnuradio/gnuradio-3.3.0.tar.gz
tar -xzf gnuradio-3.3.0.tar.gz
cd gnuradio-3.3.0
sudo ./bootstrap
sudo ./configure --prefix $HOME \
  --enable-{gnuradio-core,usrp2} \
  --disable-{usrp,docs,mblock,vrt} \
  --disable-gr-{atsc,{gsm-fr,cvsd}-vocoder,trellis,msdd6000,radio-astronomy,pager} \
  --disable-gr-{audio-{oss,alsa,jack,portaudio},video-sdl,qtgui} \
  --with-boost-libdir=/usr/lib/x86_64-linux-gnu
#Component gnuradio-core requires gruel, which is not being built or specified via pre-installed files.
make check && make install


#http://people.csail.mit.edu/szym/rawofdm/
wget -c http://people.csail.mit.edu/szym/rawofdm/rawofdm.tgz
tar xvzf rawofdm.tgz

cd rawofdm

wget -c ftp://ftp.gnu.org/gnu/gnuradio/gr-howto-write-a-block-3.3.0.tar.gz
tar -vzxf gr-howto-write-a-block-3.3.0.tar.gz

./makelinks.sh gr-howto-write-a-block-3.3.0/
./bootstrap

#./configure #falhou por conta de pacote gnuradio-core ter virado gnuradio-runtime
  #No package 'gnuradio-core' found
#'Solution': http://nuand.com/forums/viewtopic.php?t=3137
#before error:  pkg-config --modversion gnuradio-core
  #Package gnuradio-core was not found in the pkg-config search path.
  #Perhaps you should add the directory containing `gnuradio-core.pc'
  #to the PKG_CONFIG_PATH environment variable
  #No package 'gnuradio-core' found
git clone https://github.com/guruofquality/grcompat.git grcompat
cd grcompat
cmake ./
make
sudo make install
cd ../
#returns space after: pkg-config --modversion gnuradio-core
cat configure | sed 's/gnuradio-core >= 3/gnuradio-core/' > configure_mod
sed -i 's/gruel >= 3/gruel/' configure_mod
sudo chmod +x configure_mod
./configure_mod --prefix $HOME  #uggly fix

make check
#not find gr_expj.h now it is "/usr/local/include/gnuradio/expj.h"
  #change <gr_expj.h> to <gnuradio/expj.h> in
    #src/lib/ofdm/raw_ofdm_demapper.cc
    #src/lib/ofdm/raw_ofdm_frame_acquisition.cc
    #src/lib/ofdm/raw_ofdm_sampler.cc
  #change <gr_crc32.h> to <gnuradio/digital/crc32.h>
    #src/lib/qam/raw_crc.h
  #change gr_crc32 to gr::digital::crc32
    #src/lib/qam/raw_crc.cc

#TODO:


sudo make install
