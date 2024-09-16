FROM jboss/wildfly:11.0.0.Final

USER root

# Añadir un usuario administrador de WildFly
RUN /opt/jboss/wildfly/bin/add-user.sh admin admin --silent


# Añadir el archivo WAR al directorio de despliegue de WildFly
ADD target/cas.war /opt/jboss/wildfly/standalone/deployments/
#ADD deploy/cas.war.deployed /opt/jboss/wildfly/standalone/deployments/cas.war.deployed