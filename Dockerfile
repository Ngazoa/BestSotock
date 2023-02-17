FROM adoptopenjdk/openjdk11:jre-11.0.6_10-alpine
EXPOSE 9000:9000
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring
COPY Stock-1.0-SNAPSHOT.jar Stock-1.0-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","Stock-1.0-SNAPSHOT.jar"]