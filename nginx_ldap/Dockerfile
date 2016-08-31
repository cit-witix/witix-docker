FROM debian:jessie

RUN apt-get update 
RUN apt-get install -y \
		ca-certificates \
		git \
		wget

COPY nginx.conf /etc/nginx/nginx.conf
