#!/bin/bash

HTTP_STATUS="";

echo "env $ELASTICSEARCH_URL"

HOST=${ELASTICSEARCH_URL-"http://localhost:9200"}

while [[ $HTTP_STATUS != *"200"* ]]
do
	echo "Elastic server==> $HOST" 
	HTTP_STATUS="$(curl -IL --silent $HOST | grep HTTP)";
	echo "Status do Servidor Elastic => $([ -z "$HTTP_STATUS" ] && echo "-- off line --" || echo $HTTP_STATUS)";
	
	if [[ $HTTP_STATUS == *"200"* ]] ; then
		echo "ELASTICSEARCH_URL ====> $ELASTICSEARCH_URL"
		## TODO: fazer chamada direta do config_dashboards passando o diretorio PWD
		cd /tmp/dashboards
		bash /tmp/dashboards/config_dashboards.sh
		bash /tmp/templates/config_templates.sh $HOST
	else
		sleep 2;
	fi
done