# TODO change to official elasticsearch image
FROM quay.io/pires/docker-elasticsearch-kubernetes:2.3.2

ADD do_not_use.yml /elasticsearch/config/elasticsearch.yml

RUN /elasticsearch/bin/plugin install mobz/elasticsearch-head

# see more https://github.com/fabric8io/elasticsearch-cloud-kubernetes
#RUN /elasticsearch/bin/plugin install io.fabric8/elasticsearch-cloud-kubernetes/2.3.2 --verbose
# TODO see elasticsearch-cloud-gce
# see more https://github.com/elastic/elasticsearch-cloud-gce

# Override elasticsearch.yml config, otherwise plug-in install will fail
ADD elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Copy run script
COPY run.sh /