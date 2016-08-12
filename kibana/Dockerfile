FROM kibana:4.5
MAINTAINER mlacerda@ciandt.com

RUN apt-get update
RUN apt-get -y install curl

## config kibana
COPY ./conf/kibana.yml /opt/kibana/config/kibana.yml

RUN kibana plugin --install elastic/timelion
RUN kibana plugin --install elastic/sense
RUN kibana plugin --install prelert_swimlane_vis -u https://github.com/prelert/kibana-swimlane-vis/archive/v0.1.0.tar.gz
RUN kibana plugin --install kibi_timeline_vis -u https://github.com/sirensolutions/kibi_timeline_vis/raw/0.1.4/target/kibi_timeline_vis-0.1.4.zip
RUN kibana plugin --install heatmap -u https://github.com/stormpython/heatmap/archive/master.zip
RUN kibana plugin -i tagcloud -u https://github.com/stormpython/tagcloud/archive/master.zip

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