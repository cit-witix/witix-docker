#!/bin/bash

HOST=${1-"http://192.168.99.100:9200"}
echo "Host -> $HOST"

## Template para criação dos indices de request, metrics, logging e database e logtrans
curl -XPUT -H --silent "Content-Type: application/json" --data @/tmp/templates/request-template.json $HOST/_template/request
curl -XPUT -H --silent "Content-Type: application/json" --data @/tmp/templates/metrics-template.json $HOST/_template/metrics
curl -XPUT -H --silent "Content-Type: application/json" --data @/tmp/templates/logging-template.json $HOST/_template/logging
curl -XPUT -H --silent "Content-Type: application/json" --data @/tmp/templates/database-template.json $HOST/_template/database
curl -XPUT -H --silent "Content-Type: application/json" --data @/tmp/templates/logtrans-template.json $HOST/_template/logtrans

# remove Indices
# curl -XDELETE 'http://localhost:9200/request*'
# curl -XDELETE 'http://localhost:9200/database*'
# curl -XDELETE 'http://localhost:9200/logging*'
# curl -XDELETE 'http://localhost:9200/metrics*'
# curl -XDELETE 'http://localhost:9200/witix*'