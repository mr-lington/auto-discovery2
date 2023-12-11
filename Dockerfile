FROM openjdk
FROM ubuntu 
FROM tomcat
COPY **/*.war /usr/local/tomcat/webapps
WORKDIR  /usr/local/tomcat/webapps
RUN apt update -y && apt install curl -y
RUN curl -O https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/newrelic-java.zip && \
    apt-get install unzip -y  && \
    unzip newrelic-java.zip -d  /usr/local/tomcat/webapps
ENV JAVA_OPTS="$JAVA_OPTS -javaagent:app/newrelic.jar"
ENV NEW_RELIC_APP_NAME="Petadoption"
ENV NEW_RELIC_LOG_FILE_NAME=STDOUT
<<<<<<< HEAD
ENV NEW_RELIC_LICENCE_KEY="eu01xx04d64ab3674eee02dde6fd9a0bFFFFNRAL"
WORKDIR  /usr/local/tomcat/webapps
ADD ./newrelic.yml /usr/local/tomcat/webapps/newrelic/newrelic.yml
RUN pwd && ls -al
ENTRYPOINT ["java", "-javaagent:/usr/local/tomcat/webapps/newrelic/newrelic.jar", "-jar", "spring-petclinic-2.4.2.war", "--server.port=8080"]

=======
ENV NEW_RELIC_LICENCE_KEY="NRAK-N34BPC1L9265ID0OCRDO25EFQZF"
ADD ./newrelic.yml /usr/local/tomcat/webapps/newrelic/newrelic.yml
WORKDIR  /usr/local/tomcat/webapps
RUN pwd && ls -al
ENTRYPOINT ["java", "-javaagent:/usr/local/tomcat/webapps/newrelic/newrelic.jar", "-jar", "spring-petclinic-2.4.2.war", "--server.port=8085"]
>>>>>>> 42ec526bed431c467ad865734d8367a5814d4cea
