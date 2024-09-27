# Usa la imagen oficial de Tomcat
FROM tomcat:9.0

# Cambiar a usuario root para ejecutar comandos que requieran permisos elevados
USER root

# Crear un usuario 'tomcat' si no existe
RUN useradd -m -d /usr/local/tomcat tomcat

# Copiar el archivo WAR al directorio de despliegue de Tomcat
ADD target/cas.war /usr/local/tomcat/webapps/

# Asignar la propiedad de los archivos a 'tomcat'
RUN chown -R tomcat:tomcat /usr/local/tomcat

# Exponer el puerto (si es necesario)
EXPOSE 8080

# Cambiar a usuario 'tomcat' para ejecutar Tomcat con menor privilegio
USER tomcat

# Iniciar Tomcat
CMD ["catalina.sh", "run"]
