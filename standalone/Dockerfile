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
RUN useradd -ms /bin/bash jboss && chown -R jboss:jboss /opt/wildfly

#Run Wildfly
USER jboss
#Add Management user for CLI and WebConsole.
RUN /opt/wildfly/bin/add-user.sh admin Admin123 --silent

##Start Wildfly as standalone server
EXPOSE 8080
EXPOSE 9990
ENTRYPOINT /opt/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 
