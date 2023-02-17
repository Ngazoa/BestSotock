# FROM adoptopenjdk/openjdk11:jre-11.0.6_10-alpine
# EXPOSE 9000:9000
# RUN addgroup -S spring && adduser -S spring -G spring
# USER spring:spring
# COPY Stock-1.0-SNAPSHOT.jar Stock-1.0-SNAPSHOT.jar
# ENTRYPOINT ["java","-jar","Stock-1.0-SNAPSHOT.jar"]


FROM adoptopenjdk/openjdk8:alpine-jre
ARG JAR_FILE=Stock-1.0-SNAPSHOT.jar
WORKDIR /opt/app
# Copy the spring-boot-api-tutorial.jar from the maven stage to the /opt/app directory of the current stage.
COPY --from=maven /usr/src/app/target/${JAR_FILE} /opt/app/

ENTRYPOINT ["java","-jar","Stock-1.0-SNAPSHOT.jar"]