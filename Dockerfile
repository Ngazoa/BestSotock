FROM maven:3-jdk-8-alpine AS build

COPY ./ /opt/app
WORKDIR /opt/app
RUN mvn clean install -DskipTests


FROM openjdk:8-jdk-alpine
COPY --from=build /opt/app/target/*.jar app.jar

ENV PORT 5000
EXPOSE $PORT

ENTRYPOINT ["java","-jar", "app.jar"]
