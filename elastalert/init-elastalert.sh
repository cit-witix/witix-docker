#!/bin/bash

# Based on https://github.com/krizsan/elastalert-docker
echo "Starting Alerting"

# Wait for the Elasticsearch container to be ready before starting Kibana.
echo "Waiting for Elasticsearch to startup"
while true; do
    curl $ELASTICSEARCH_URL 2>/dev/null && break
    echo "WARNING: Trying connect to elasticsearch $ELASTICSEARCH_URL"
    sleep 1
done

# Set the timezone.
if [ "$SET_CONTAINER_TIMEZONE" = "true" ]; then
	unlink /etc/localtime
	ln -s /usr/share/zoneinfo/${CONTAINER_TIMEZONE} /etc/localtime && \
	echo "Container timezone set to: $CONTAINER_TIMEZONE"
else
	echo "Container timezone not modified"
fi

if [[ -n "${ELASTICSEARCH_USERNAME:-}" ]]
then
	flags="--user ${ELASTICSEARCH_USERNAME}:${ELASTICSEARCH_PASSWORD}"
else
	flags=""
fi

if ! curl -f $flags ${ELASTICSEARCH_URL} >/dev/null 2>&1
then
	echo "Elasticsearch not available at ${ELASTICSEARCH_URL}"
else
	if ! curl -f $flags ${ELASTICSEARCH_URL}/elastalert_status >/dev/null 2>&1
	then
		echo "Creating Elastalert index in Elasticsearch at ${ELASTICSEARCH_URL}..."
	    elastalert-create-index --index elastalert_status --old-index ""
	else
	    echo "Elastalert index already exists in Elasticsearch."
	fi
fi

cd /opt/elastalert

echo "Call pythong elastalert.elastalert"
python -m elastalert.elastalert --verbose