# Bombaju's Dockerfiles

All images are created using bombaju/base image (https://hub.docker.com/r/bombaju/base/) which is built with Debian Jessie base + some useful tools

Base Dockerfile that includes oracle jre 8

Additional Dockerfiles that includes Wildfly Application server in different configurations

# Usage
Before use in your environment, please change or check passwords in Dockerfile's and jboss-logmanager.sh

If You want to use node configuration please check IP in node/Dockerfile, You may also want to check in host-slave.xml where is configured domain connection user and secret
