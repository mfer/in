#!/bin/bash
#MODULE=$1
MODULE='AAA'
gr_modtool newmod $MODULE
cd 'gr-'$MODULE
gr_modtool add -t sync -l python < 'bla_py_ff
bla
n'

echo '<?xml version="1.0"?>
<block>
  <name>counter_py_ff</name>
  <key>netstat_counter_py_ff</key>
  <category>netstat</category>
  <import>import netstat</import>
  <make>netstat.counter_py_ff($counter)</make>
  <!-- Make one 'param' node for every Parameter you want settable from the GUI.
       Sub-nodes:
       * name
       * key (makes the value accessible as $keyname, e.g. in the make node)
       * type
  <param>
    <name>...</name>
    <key>...</key>
    <type>...</type>
  </param>-->

  <!-- Make one 'sink' node per input. Sub-nodes:
       * name (an identifier for the GUI)
       * type
       * vlen
       * optional (set to 1 for optional inputs) -->
  <sink>
    <name>in</name>
    <type>float</type>
  </sink>

  <!-- Make one 'source' node per output. Sub-nodes:
       * name (an identifier for the GUI)
       * type
       * vlen
       * optional (set to 1 for optional inputs) -->
  <source>
    <name>out</name>
    <type>float</type>
  </source>
</block>
' > './grc/'$MODULE'_bla.xml'


echo '#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright 2015 <+YOU OR YOUR COMPANY+>.
#
# This is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this software; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.
#

import numpy
from gnuradio import gr

class counter_py_ff(gr.sync_block):
    """
    docstring for block counter_py_ff
    """
    contador = 0

    def __init__(self, counter):
        gr.sync_block.__init__(self,
            name="counter_py_ff",
            in_sig =[numpy.float32],#in_sig=[<+numpy.float+>],
            out_sig = [numpy.float32])#out_sig=[<+numpy.float+>])


    def work(self, input_items, output_items):
        in0 = input_items[0]
        out = output_items[0]
        # <+signal processing here+>
        self.contador = self.contador + 1
        out[:] = in0 * self.contador
        print self.contador
        #out[:] = in0
        return len(output_items[0])
' > ./python/bla.py

mkdir build
cd build
cmake ../ && make && sudo make install && sudo ldconfig
