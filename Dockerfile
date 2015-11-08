FROM bombaju/base

MAINTAINER bombaju@bombaju.pl

WORKDIR /opt
#Update system
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
#Get latest oracle jre8 package
ADD http://javadl.sun.com/webapps/download/AutoDL?BundleId=111681 jdk.tgz
RUN tar -xf /opt/jdk.tgz && rm -f /opt/jdk.tgz
RUN mv -f /opt/jre*/ /opt/java
ENV JAVA_HOME /opt/java
ENV PATH $PATH:/opt/java/bin
#Get latest Final Wildfly package
ADD http://download.jboss.org/wildfly/9.0.2.Final/wildfly-9.0.2.Final.tar.gz wfly.tgz 
RUN tar -xf /opt/wfly.tgz && mv -f /opt/wildfly-9.0.2.Final /opt/wildfly &&  rm -f /opt/wfly.tgz
ENV JBOSS_HOME /opt/wildfly
#Add Jboss as Wildfly user
RUN useradd -ms /bin/bash jboss && chown -R jboss:jboss /opt/wildfly

#Run Wildfly
USER jboss
#Add Management user for CLI and WebConsole.
RUN /opt/wildfly/bin/add-user.sh admin Admin123 --silent

##Start Wildfly as standard Domain.
#ENTRYPOINT /opt/wildfly/bin/domain.sh -b 0.0.0.0 -bmanagement 0.0.0.0 
#EXPOSE 9990
#EXPOSE 8080
##Start Wildfly as standalone server
#EXPOSE 8080
#EXPOSE 9990
#ENTRYPOINT /opt/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 
##Start Wildfly Manager only with separated profile directory
RUN cp -rf /opt/wildfly/domain /opt/wildfly/master
EXPOSE 9990
EXPOSE 9999
ENTRYPOINT  /opt/wildfly/bin/domain.sh -b 0.0.0.0 -bmanagement 0.0.0.0 --host-config=host-master.xml -Djboss.domain.base.dir=/opt/wildfly/master
