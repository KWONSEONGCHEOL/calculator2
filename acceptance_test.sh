#!/bin/bash
#test $(curl --silent localhost:8090/sum?a=1\&b=2) -eq 3 || \    # true when it runs on host
#test $(curl --silent $(docker network inspect -f '{{range .IPAM.Config}}{{.Gateway}}{{end}}' bridge):8090/sum?a=1\&b=2) -eq 3  # true on docker

CALCULATOR_PORT=$(docker-compose port calculator 8090 | cut -d: -f2)
echo $CALCULATOR_PORT
test $(curl --silent 172.24.0.1:$CALCULATOR_PORT/sum?a=10\&b=20) -eq 30


