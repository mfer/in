#!/bin/bash
sudo mn --topo tree,2 --controller remote,$(ipdocker onos1),6633 --mac