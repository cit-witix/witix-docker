#!/bin/bash

print_usage() {
  echo "
  
Load the dashboards, visualizations and index patterns into the given
Elasticsearch instance.

Usage:
  $(basename "$0") -u your-username -password your-secret-password

Options:
  -h | -help
    Print the help menu.
  -u | -username
    Docker HUB username. 
  -p | -password
    Password for authenticating to Docker Hub using Basic
    Authentication.
" >&2
}

while [ "$1" != "" ]; do
case $1 in
    -u | -username )
        DOCKER_USERNAME=$2
        if [ "$DOCKER_USERNAME" = "" ]; then
            echo "Error: Missing username"
            print_usage
            exit 1
        fi
        ;;

    -p | -password )
        DOCKER_PASSWORD=$2
        if [ "$DOCKER_PASSWORD" = "" ]; then
            echo "Error: Missing password"
            print_usage
            exit 1
        fi
        ;;

    -h | -help )
        print_usage
        exit 0
        ;;

     *)
        echo "Error: Unknown option $2"
        print_usage
        exit 1
        ;;

esac
shift 2
done

if [ -z "$DOCKER_USERNAME"  ] 
then
    print_usage
    exit 1
fi


export REPO=ciandtsoftware/witix-elastalert
export TAG=3.0.2-alpha

echo "Login Docker Repo..."
docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"

echo "Build docker image $REPO:$TAG..."
docker build -f Dockerfile -t $REPO:$TAG .

echo "Push to $REPO"
docker push $REPO

echo "Build success!!"