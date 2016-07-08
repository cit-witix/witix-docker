FROM kibana:4.5
MAINTAINER mlacerda@ciandt.com

RUN apt-get update
RUN apt-get -y install curl

## config kibana
COPY ./conf/kibana.yml /opt/kibana/config/kibana.yml

# Pendencia_Auth COPY conf/auth.js /opt/kibana/src/lib/auth.js

RUN kibana plugin --install elastic/timelion
RUN kibana plugin --install elastic/sense

# set variables

## loading kibana dashboads definitions
COPY dashboards /tmp/dashboards/
RUN chmod +x /tmp/dashboards/config_dashboards.sh
RUN sed -i -e 's/\r$//' /tmp/dashboards/config_dashboards.sh

COPY templates /tmp/templates
RUN chmod +x /tmp/templates/config_templates.sh
RUN sed -i -e 's/\r$//' /tmp/templates/config_templates.sh  

## start kibana command
COPY docker-witix-entrypoint.sh /tmp/docker-witix-entrypoint.sh
RUN chmod +x /tmp/docker-witix-entrypoint.sh	
RUN sed -i -e 's/\r$//' /tmp/docker-witix-entrypoint.sh

## start kibana command
COPY check_elastic.sh /tmp/check_elastic.sh
RUN chmod +x /tmp/check_elastic.sh	
RUN sed -i -e 's/\r$//' /tmp/check_elastic.sh

COPY witix-console.svg /opt/kibana/optimize/bundles/src/ui/public/images/kibana.svg
# fix kibana 4.5 and sense plugin
RUN chmod o+w /opt/kibana/optimize/.babelcache.json

ENTRYPOINT ["/tmp/docker-witix-entrypoint.sh"]
CMD ["kibana"]