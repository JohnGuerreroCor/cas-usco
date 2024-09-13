#FROM jboss/wildfly:11.0.0.Final
#
#USER root
#
## Desactivar mirrors y usar baseurl para CentOS
#RUN sed -i 's|^mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-Base.repo && \
#    sed -i 's|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo && \
#    yum clean all && \
#    yum install -y java-1.8.0-openjdk-devel \
#    && yum clean all \
#    && yum install maven -y
#
#
#COPY . .
#
#RUN mvn clean install
#
#
## Definir JAVA_HOME con el formato correcto
#ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0
#
## Añadir un usuario administrador de WildFly
#RUN /opt/jboss/wildfly/bin/add-user.sh admin admin --silent
#
#
## Añadir el archivo WAR al directorio de despliegue de WildFly
##ADD target/cas.war /opt/jboss/wildfly/standalone/deployments/
#
#
#RUN cp target/*.war /opt/jboss/wildfly/standalone/deployments/
#
## Utilizar la imagen base de WildFly
#
#
#FROM jboss/wildfly:11.0.0.Final
#
## Cambiar a usuario root para instalar dependencias
#USER root
#
## Actualizar repositorios y mirrors de CentOS, instalar OpenJDK 1.8 y Maven
#RUN sed -i 's|^mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-Base.repo && \
#    sed -i 's|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo && \
#    yum clean all && \
#    yum install -y java-1.8.0-openjdk-devel maven dos2unix && \
#    yum clean all
#
## Definir JAVA_HOME para el sistema
#ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0
#
## Copiar todo el contenido del proyecto al contenedor
#COPY . .
#
## Convertir build.sh y mvnw a formato Unix
#RUN dos2unix ./build.sh ./mvnw
#
## Ejecutar el script build.sh para construir el proyecto
#RUN chmod +x ./build.sh && ./build.sh package
#
## Añadir un usuario administrador para WildFly
#RUN /opt/jboss/wildfly/bin/add-user.sh admin admin --silent
#
## Copiar el archivo WAR generado al directorio de despliegue de WildFly
#RUN cp target/*.war /opt/jboss/wildfly/standalone/deployments/
#
## Exponer los puertos 8080 (HTTP) y 8443 (HTTPS)
#EXPOSE 8080 8443
#
## Comando para iniciar WildFly
#CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]

## Usa una imagen base de JDK
#FROM openjdk:8-jdk-alpine
#
## Copiar los archivos del proyecto al contenedor
#COPY . /cas-overlay
#
## Establece el directorio de trabajo
#WORKDIR /cas-overlay
#
## Instala dos2unix para manejar problemas de salto de línea
#RUN apk add --no-cache dos2unix
#
## Convierte los archivos a formato LF (si es necesario)
#RUN dos2unix build.sh mvnw
#
## Da permisos de ejecución a los scripts
#RUN chmod +x build.sh mvnw
#
## Ejecuta el script de build para empaquetar la aplicación
#RUN ./build.sh package
#
## Copia el WAR generado al directorio de despliegue de WildFly
#COPY target /opt/jboss/wildfly/standalone/deployments/
#
## Exponer los puertos necesarios para CAS
#EXPOSE 8080 8443


#FROM jboss/wildfly:11.0.0.Final
#
#USER root
#
#RUN sed -i 's|^mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-Base.repo && \
#    sed -i 's|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo && \
#    yum clean all && \
#    yum install -y java-1.8.0-openjdk-devel maven && \
#    yum clean all
#
#COPY src /src
#COPY pom.xml .
#
#RUN mvn clean install && \
#    cp target/*.war /opt/jboss/wildfly/standalone/deployments/
#
#ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0
#
#RUN /opt/jboss/wildfly/bin/add-user.sh admin admin --silent

FROM jboss/wildfly:11.0.0.Final

USER root

# Desactivar mirrors y usar baseurl para CentOS
#RUN sed -i 's|^mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-Base.repo && \
#    sed -i 's|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo && \
#    yum clean all && \
#    yum install -y java-1.8.0-openjdk-devel \
#    && yum clean all \
#    && yum install maven -y \
#    && yum clean all \




#RUN mvn clean install

# Definir JAVA_HOME con el formato correcto
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0

# Añadir un usuario administrador de WildFly
RUN /opt/jboss/wildfly/bin/add-user.sh admin admin --silent


# Añadir el archivo WAR al directorio de despliegue de WildFly
ADD target/cas.war /opt/jboss/wildfly/standalone/deployments/

#RUN cp target/*.war /opt/jboss/wildfly/standalone/deployments/