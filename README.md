# Bombaju's Dockerfiles

All images are created using bombaju/base image (https://hub.docker.com/r/bombaju/base/) which is built with Debian Jessie base + some useful tools

Base Dockerfile, includes oracle jre 8

Additional Dockerfiles, includes Wildfly Application server in different configurations

# Usage

Before use this files in Your environment, please change/check passwords in Dockerfile's and jboss-logmanager.sh.

In Domain Configuration's You need to check Master IP Address, 
If You want to use node configuration please check IP in node/Dockerfile, You may also check  "host-slave.xml", where is configured domain connection user and secret

If you want to use Logstash, You need to change  domain authentication data  and IP in jboss-logmanager.sh and run it  while Wildfly is running using "docker exec" command.
