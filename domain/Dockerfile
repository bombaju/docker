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
#Get latest Final Wildfly package
ADD http://download.jboss.org/wildfly/10.0.0.Final/wildfly-10.0.0.Final.tar.gz wfly.tgz 
RUN tar -xf /opt/wfly.tgz && mv -f /opt/wildfly-10.0.0.Final /opt/wildfly &&  rm -f /opt/wfly.tgz
ENV JBOSS_HOME /opt/wildfly

#Add Jboss as Wildfly user
RUN useradd -ms /bin/bash jboss

#Add Logstash support
COPY jboss-logmanager-ext-module.tgz /opt/jboss-logmanager-ext-module.tgz
RUN tar -xf /opt/jboss-logmanager-ext-module.tgz -C /opt/wildfly/modules/ && rm /opt/jboss-logmanager-ext-module.tgz
COPY jboss-logmanager.sh /opt/wildfly/bin/jboss-logmanager.sh

#Take ownership of files
RUN chown -R jboss:jboss /opt/wildfly

#Set Jboss as Wildfly user
USER jboss
#Add Management user for CLI and WebConsole.
RUN /opt/wildfly/bin/add-user.sh admin Admin123 --silent

##Start Wildfly as standard Domain.
EXPOSE 9990
EXPOSE 8080
EXPOSE 8180
EXPOSE 8230
ENTRYPOINT /opt/wildfly/bin/domain.sh -b 0.0.0.0 -bmanagement 0.0.0.0
