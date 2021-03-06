#!/bin/bash
#MODULE=$1
MODULE='ModuleName2'
BLOCK='BlockName2'

rm -rf ../workspace
mkdir ../workspace
cd ../workspace
gr_modtool newmod $MODULE
cd 'gr-'$MODULE
echo $BLOCK'_py_ff
'$BLOCK'
n' > gr_modtool_add_answers
gr_modtool add -t sync -l python < gr_modtool_add_answers

echo '<?xml version="1.0"?>
<block>
  <name>'$BLOCK'_py_ff</name>
  <key>'$MODULE'_'$BLOCK'_py_ff</key>
  <category>'$MODULE'</category>
  <import>import '$MODULE'</import>
  <make>'$MODULE'.'$BLOCK'_py_ff($'$BLOCK')</make>
  <sink>
    <name>in</name>
    <type>float</type>
  </sink>
  <source>
    <name>out</name>
    <type>float</type>
  </source>
</block>
' > './grc/'$MODULE'_'$BLOCK'_py_ff.xml'


echo '#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright 2015 <manassesferreira at dcc dot ufmg>.
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

class '$BLOCK'_py_ff(gr.sync_block):
    """
    docstring for block '$BLOCK'_py_ff
    """
    contador = 0

    def __init__(self, counter):
        gr.sync_block.__init__(self,
            name="'$BLOCK'_py_ff",
            in_sig =[numpy.float32],
            out_sig = [numpy.float32])

    def work(self, input_items, output_items):
        in0 = input_items[0]
        out = output_items[0]
        self.contador = self.contador + 1
        out[:] = in0 * self.contador
        print self.contador
        return len(output_items[0])
' > './python/'$BLOCK'_py_ff.py'

rm -rf build
mkdir build
cd build
cmake ../
make
sudo make install
sudo ldconfig
