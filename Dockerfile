FROM bombaju/base

MAINTAINER bombaju@bombaju.pl

WORKDIR /opt
#Update system
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
#Get latest oracle jre8 package
ADD http://javadl.sun.com/webapps/download/AutoDL?BundleId=111681 jre.tgz
RUN tar -xf /opt/jre.tgz && rm -f /opt/jre.tgz
RUN mv -f /opt/jre*/ /opt/java
ENV JAVA_HOME /opt/java
ENV PATH $PATH:/opt/java/bin
