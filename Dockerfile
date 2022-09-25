FROM maven:3-jdk-8-alpine AS build

WORKDIR  /app
#COPY ./ /opt/app
COPY pom.xml /app/pom.xml

RUN mvn clean install


FROM openjdk:8-jdk-alpine
COPY --from=build /app/target/*.jar app.jar

ENV PORT 5000
EXPOSE $PORT

ENTRYPOINT ["java","-jar", "app.jar"]
