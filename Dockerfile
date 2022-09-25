FROM maven:3-jdk8:alpine AS build

WORKDIR /opt/app

COPY ./ /opt/app
RUN mvn clean install


FROM openjdk8:alpine
COPY from=build /opt/app/target/*.jar app.jar/

ENV PORT 5000
EXPOSE $PORT

ENTRYPOINT ["java","-jar", "app.jar"]
