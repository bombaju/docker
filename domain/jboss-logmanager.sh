#!/bin/bash

JBOSS_HOME=/opt/wildfly
USER=admin
PASS=Admin123
LOGSTASHIP=192.168.0.6
$JBOSS_HOME/bin/jboss-cli.sh -u=$USER -p=$PASS -c << EOF

batch

# Add the logstash formatter
/profile=default/subsystem=logging/custom-formatter=logstash:add(class=org.jboss.logmanager.ext.formatters.LogstashFormatter,module=org.jboss.logmanager.ext)
/profile=ha/subsystem=logging/custom-formatter=logstash:add(class=org.jboss.logmanager.ext.formatters.LogstashFormatter,module=org.jboss.logmanager.ext)
/profile=full/subsystem=logging/custom-formatter=logstash:add(class=org.jboss.logmanager.ext.formatters.LogstashFormatter,module=org.jboss.logmanager.ext)
/profile=full-ha/subsystem=logging/custom-formatter=logstash:add(class=org.jboss.logmanager.ext.formatters.LogstashFormatter,module=org.jboss.logmanager.ext)

# Add a socket-handler using the logstash formatter. Replace the hostname and port to the values needed for your logstash install
/profile=default/subsystem=logging/custom-handler=logstash-handler:add(class=org.jboss.logmanager.ext.handlers.SocketHandler,module=org.jboss.logmanager.ext,named-formatter=logstash,properties={hostname=$LOGSTASHIP, port=5000})
/profile=ha/subsystem=logging/custom-handler=logstash-handler:add(class=org.jboss.logmanager.ext.handlers.SocketHandler,module=org.jboss.logmanager.ext,named-formatter=logstash,properties={hostname=$LOGSTASHIP, port=5000})
/profile=full/subsystem=logging/custom-handler=logstash-handler:add(class=org.jboss.logmanager.ext.handlers.SocketHandler,module=org.jboss.logmanager.ext,named-formatter=logstash,properties={hostname=$LOGSTASHIP, port=5000})
/profile=full-ha/subsystem=logging/custom-handler=logstash-handler:add(class=org.jboss.logmanager.ext.handlers.SocketHandler,module=org.jboss.logmanager.ext,named-formatter=logstash,properties={hostname=$LOGSTASHIP, port=5000})

# Add the new handler to the root-logger
/profile=default/subsystem=logging/root-logger=ROOT:add-handler(name=logstash-handler)
/profile=ha/subsystem=logging/root-logger=ROOT:add-handler(name=logstash-handler)
/profile=full/subsystem=logging/root-logger=ROOT:add-handler(name=logstash-handler)
/profile=full-ha/subsystem=logging/root-logger=ROOT:add-handler(name=logstash-handler)

# Reload the server which will boot the server into normal mode as well as write messages to logstash

run-batch
EOF
