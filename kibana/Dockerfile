FROM kibana:latest
MAINTAINER mlacerda@ciandt.com

RUN apt-get update
RUN apt-get -y install curl

## config kibana
COPY ./conf/kibana.yml /opt/kibana/config/kibana.yml

#RUN kibana plugin -i tagcloud -u https://github.com/stormpython/tagcloud/archive/master.zip
#RUN kibana-plugin install x-pack

RUN kibana-plugin install https://github.com/leandroandrade87/kibana-plugin-traffic-sg/releases/download/5.1.2/traffic-sg-5.1.2.zip
RUN kibana-plugin install https://github.com/leandroandrade87/kibana-plugin-line-sg/releases/download/v5.1.2/line-sg.zip
RUN kibana-plugin install https://github.com/leandroandrade87/kibana-swimlane-vis/releases/download/v5.1.2/swimlane-vis.zip
#RUN kibana-plugin install https://github.com/leandroandrade87/kbn_c3js_vis/releases/download/v5.1.2/kbn_c3js_vis.zip
#RUN npm install
RUN kibana-plugin install https://github.com/leandroandrade87/kibana-plugin-gauge-sg/releases/download/v5.1.2/gauge-sg.zip
RUN kibana-plugin install https://github.com/leandroandrade87/kibana_health_metric_vis/releases/download/v5.1.2/health_metric_vis.zip
RUN ["apt-get", "install", "-y", "vim"]


# set variables

## loading kibana dashboads definitions
#COPY dashboards /tmp/dashboards/
#RUN chmod +x /tmp/dashboards/config_dashboards.sh
#RUN sed -i -e 's/\r$//' /tmp/dashboards/config_dashboards.sh

#COPY templates /tmp/templates
#RUN chmod +x /tmp/templates/config_templates.sh
#RUN sed -i -e 's/\r$//' /tmp/templates/config_templates.sh  

## start kibana command
COPY docker-witix-entrypoint.sh /tmp/docker-witix-entrypoint.sh
RUN chmod +x /tmp/docker-witix-entrypoint.sh	
RUN sed -i -e 's/\r$//' /tmp/docker-witix-entrypoint.sh

## start kibana command
COPY check_elastic.sh /tmp/check_elastic.sh
RUN chmod +x /tmp/check_elastic.sh	
RUN sed -i -e 's/\r$//' /tmp/check_elastic.sh

COPY witix-console.svg /opt/kibana/optimize/bundles/src/ui/public/images/kibana.svg
COPY index.js /usr/share/kibana/src/ui/public/agg_types/index.js
COPY sumPedroh.js /usr/share/kibana/src/ui/public/agg_types/metrics/sumPedroh.js
COPY sum.js /usr/share/kibana/src/ui/public/agg_types/metrics/sum.js
# fix kibana 4.5 and sense plugin
#RUN chmod o+w /opt/kibana/optimize/.babelcache.json

ENTRYPOINT ["/tmp/docker-witix-entrypoint.sh"]
CMD ["kibana"]
