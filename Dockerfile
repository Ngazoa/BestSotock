FROM tomcat:8.0-alpine

LABEL maintainer="Nidhi Gupta"

ADD ./target/StokApp-1.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]

#FROM openjdk:8-jdk-alpine
#ARG JAR_FILE=target/*.jar
#COPY ${JAR_FILE} app.jar
#ENTRYPOINT ["java","-jar","/app.jar"]





#FROM maven:3-jdk-8-alpine AS build
#
#WORKDIR  /app
##COPY ./ /opt/app
#COPY pom.xml /app/pom.xml
#
#RUN mvn clean install
#
#
#FROM openjdk:8-jdk-alpine
#COPY --from=build /app/target/*.jar app.jar
#
#ENV PORT 5000
#EXPOSE $PORT
#
#ENTRYPOINT ["java","-jar", "app.jar"]
