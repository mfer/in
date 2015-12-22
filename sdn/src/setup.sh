#!/bin/bash

#ATTENTION: this routine needs the docker container ---> available at https://mega.nz/#!SVBRXD7K
#____ to start the docker VM
xterm -e ./start_onos.sh &
echo "waiting ONOS initialization"
sleep 15
/usr/bin/google-chrome http://localhost:8181/onos/ui/index.html#topo &

#xterm -hold -e ./start_mininet.sh

#sudo apt-get install sshpass
#sshpass -p "karaf" ssh karaf@$(ipdocker onos1) -p 8101 "ls" 
#"app activate org.onosproject.openflow"
docker exec -ti onos1 ./bin/onos app activate org.onosproject.openflow 

cd proactone-firewall/
mvn clean install && onos-app $(ipdocker onos1) reinstall! target/proactone-firewall-1.0-SNAPSHOT.oar

cd ../proacttwo-firewall/
mvn clean install && onos-app $(ipdocker onos1) reinstall! target/proacttwo-firewall-1.0-SNAPSHOT.oar

#docker exec -ti onos1 ./bin/onos app activate org.onosproject.fwd 
cd ../intentSwitch
mvn clean install && onos-app $(ipdocker onos1) reinstall! target/intent-switch-app-1.3.0-SNAPSHOT.oar

echo "making topology"
#sleep 10
#xterm -e ./start_mininet.sh && xterm -hold -e ./start_mininet.sh
sudo mn --topo tree,2 --controller remote,$(ipdocker onos1),6633 --mac


#type To make the host discovery
#mininet> pingall
#minitet> type h1 ping h4

#type To see that the appTwo conflicts with appOne
#onos> proactonefirewall:fwadd-dstrule 10.0.0.4
#onos> proacttwofirewall:fwadd-dstrule 10.0.0.4
#onos> proacttwofirewall:fwremove-dstrule 10.0.0.4
#onos> proactonefirewall:fwremove-dstrule 10.0.0.4

