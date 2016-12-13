FROM debian:jessie
MAINTAINER mlacerda@ciandt.com

# see reference https://hub.docker.com/r/ivankrizsan/elastalert/~/dockerfile/

# config elastalert
ENV SET_CONTAINER_TIMEZONE false
ENV CONTAINER_TIMEZONE America/Los_Angeles
ENV ELASTALERT_VERSION 0.1.4
ENV ELASTALERT_URL https://github.com/Yelp/elastalert/archive/v${ELASTALERT_VERSION}.tar.gz
ENV ELASTALERT_HOME /opt/elastalert
ENV RULES_DIRECTORY /opt/elastalert/rules

ENV ELASTICSEARCH_URL http://witix-elasticsearch:9200
ENV ELASTICSEARCH_HOST http://witix-elasticsearch
ENV ELASTICSEARCH_PORT 9200
ENV ELASTICSEARCH_USERNAME ""
ENV ELASTICSEARCH_PASSWORD ""

RUN apt-get update 
RUN apt-get -y install curl
RUN apt-get install tar python-dev build-essential tzdata -y

RUN curl -Lo get-pip.py https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

RUN mkdir -p /opt/elastalert

RUN curl -Lo elastalert.tar.gz ${ELASTALERT_URL} && \
    tar xvf *.tar.gz -C ${ELASTALERT_HOME} --strip-components 1 && \
    rm *.tar.gz

WORKDIR /opt/elastalert

RUN mkdir rules

COPY ./conf/config.yaml /opt/elastalert/
COPY ./conf/rules/*.yaml /opt/elastalert/rules/ 

RUN python setup.py install && \
    pip install -e .

COPY ./init-elastalert.sh /init-elastalert.sh
RUN chmod +x /init-elastalert.sh
RUN sed -i 's/\r$//' /init-elastalert.sh

RUN curl -Lo elastalert.tar.gz ${ELASTALERT_URL} && \
    tar xvf *.tar.gz -C ${ELASTALERT_HOME} --strip-components 1 && \
    rm *.tar.gz

CMD ["/init-elastalert.sh"]
