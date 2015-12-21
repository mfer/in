#!/bin/bash
docker stop onos1; docker rm onos1; docker run -td -p 8181:8181 -p 6633:6633 -h onos1 --name onos1 heitormotta/sci-onos:run; docker exec -ti onos1 ./bin/onos-service