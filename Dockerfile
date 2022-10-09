
#FROM maven:3.8.1 AS maven
#LABEL MAINTAINER="benito@benito.com"
#
#WORKDIR /usr/src/app
#COPY . /usr/src/app
## Compile and package the application to an executable JAR
#RUN mvn package
#
## For Java 11,
#FROM adoptopenjdk/openjdk8:alpine-jre
#ARG JAR_FILE=Stock-1.0-SNAPSHOT.jar
#WORKDIR /opt/app
## Copy the spring-boot-api-tutorial.jar from the maven stage to the /opt/app directory of the current stage.
#COPY --from=maven /usr/src/app/target/${JAR_FILE} /opt/app/
#
#ENTRYPOINT ["java","-jar","Stock-1.0-SNAPSHOT.jar"]






#FROM tomcat:8.0-alpine
#
#LABEL maintainer="Nidhi Gupta"
#
#ADD ./target/Stock-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/  ***************************++++++
#
#EXPOSE 8080
#
#CMD ["catalina.sh", "run"]
#
FROM openjdk:8-jdk-alpine
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
#
#
#
#
#
##FROM maven:3-jdk-8-alpine AS build
##
##WORKDIR  /app
###COPY ./ /opt/app
##COPY pom.xml /app/pom.xml
##
##RUN mvn clean install
##
##
##FROM openjdk:8-jdk-alpine
##COPY --from=build /app/target/*.jar app.jar
##
##ENV PORT 5000
##EXPOSE $PORT
##
##ENTRYPOINT ["java","-jar", "app.jar"]







#FROM tomcat:8.0-alpine
#
#LABEL maintainer="Nidhi Gupta"
#
#ADD ./target/Stock-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/  ***************************++++++
#
#EXPOSE 8080
#
#CMD ["catalina.sh", "run"]
#
#FROM openjdk:8-jdk-alpine
#ARG JAR_FILE=target/*.jar
#COPY ${JAR_FILE} app.jar
#ENTRYPOINT ["java","-jar","/app.jar"]
#
#
#
#
#
##FROM maven:3-jdk-8-alpine AS build
##
##WORKDIR  /app
###COPY ./ /opt/app
##COPY pom.xml /app/pom.xml
##
##RUN mvn clean install
##
##
##FROM openjdk:8-jdk-alpine
##COPY --from=build /app/target/*.jar app.jar
##
##ENV PORT 5000
##EXPOSE $PORT
##
##ENTRYPOINT ["java","
