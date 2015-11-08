FROM bombaju/base

MAINTAINER bombaju@bombaju.pl

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
