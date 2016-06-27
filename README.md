# Introdução
Imagem docker configurada para o Kibana, Elasticsearch e Elastalert. Necessário ter o docker e git instalado para continuar com o setup abaixo


# Setup

## Usando Docker Compose
Utilizando o docker

```console
$ git clone https://github.com/cit-witix/witix-docker.git
$ cd witix-docker
$ docker-compose up
```

O comendo **docker-compose up** já inicia três containers configurados no arquivo docker-compose.yml, fazendo os links necessários. Importante observar que primeira execução será mais demorada, pois as imagens serão construídas (build) e as dependencias (kibana, elasticsearch, logstash, debian) baixadas do repositório central [docker hub](http://hub.docker.com). O arquivo abaixo mostra a configuração do docker-compose

```yaml
version: '2'
services:
    witix-elasticsearch:
        build: elasticsearch/
        ports:
            - "9200:9200"
            - "9300:9300"
    witix-kibana:
        build: kibana/
        depends_on: 
            - witix-elasticsearch
        ports:
            - "5601:5601"
        environment:
            - ELASTICSEARCH_URL=http://witix-elasticsearch:9200    
    witix-elastalert:
        build: elastalert/
        depends_on: 
            - witix-elasticsearch
        volumes:
            - ./elastalert/conf/config.yaml:/opt/elastalert/config.yaml
            - ./elastalert/conf/rules/:/opt/elastalert/rules                    
```

Após iniciar os três containers, utilize as URLs abaixo para acessar os serviços: 

* http://localhost:9200/_plugin/head
* http://localhost:5601

Como enviar dados para o elasticsearch? Veja alguns exemplos em [Samples](witix-samples/readme.md)

## Elasticsearch 
O comando abaixo constroi e executa o elasticsearch individualmente. 

```shell
cd elasticsearch
docker build -t witixdocker_witix-elasticsearch
# expose on port 9200. Param --name is used to link docker with another images
docker run -p 9200:9200 --name=witix-elasticsearch  witixdocker_witix-elasticsearch
```

## ElastAlert

Os comandos abaixo fazem o build da imagem docker para o elastalert
```shell
cd elastalert
docker build -t witixdocker_witix-elastalert . 
docker run --link witix-elasticsearch:witix-elasticsearch witixdocker_witix-elastalert
```

## Kibana
O comando abaixo constroi e executa o elasticsearch individualmente. 

```shell
cd kibana
docker build -t witixdocker_witix-kibana
# expose on port 5601. Param link is used to link elasticsearch host
docker run -p 5601:5601 --name=witix-kibana --link witix-elasticsearch:witix-elasticsearch witixdocker_witix-kibana
```

## Petclinic
O comando abaixo, executa aplicação demo petclinic, já instrumentada com os plugins do witix. 

```shell
cd witix-samples/witix-spring-petclinic/
# Require JDK 1.7 and maven 3.3.3 or superior 
mvn tomcat7:run -Dmetrics.enabled=true -Dwitix.elasticsearch.url=http://[Elasticsearch Host]<:[port]> -Dwitix.applicationName=PETCLINIC -Dwitix.requestmonitor.http.collectHeaders=true -Dwitix.web.paths.excluded="/javax.faces.resource, /resources"
```