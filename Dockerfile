FROM adoptopenjdk/openjdk11:jre-11.0.6_10-alpine
EXPOSE 9000
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring
#COPY Stock-1.0-SNAPSHOT.jar Stock-1.0-SNAPSHOT.jar
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} Stock-1.0-SNAPSHOT.jar
COPY mysql.cnf /etc/mysql/conf.d/

RUN apt-get update && apt-get install -y mysql-client && apt-get clean

    ENV MYSQL_DATABASE=akouma_stock
    ENV MYSQL_USER=root
    ENV MYSQL_PASSWORD=
    ENV MYSQL_ROOT_PASSWORD=
#ENTRYPOINT ["java","-jar","/Stock-1.0-SNAPSHOT.jar"]
ENTRYPOINT ["java","-jar","Stock-1.0-SNAPSHOT.jar","--spring.datasource.url=jdbc:mysql://localhost:3306/akouma_stock?useSSL=false"]


# FROM adoptopenjdk/openjdk8:alpine-jre
# ARG JAR_FILE=Stock-1.0-SNAPSHOT.jar
# WORKDIR /opt/app
# # Copy the spring-boot-api-tutorial.jar from the maven stage to the /opt/app directory of the current stage.
# COPY --from=maven /usr/src/app/target/${JAR_FILE} /opt/app/
#
# ENTRYPOINT ["java","-jar","Stock-1.0-SNAPSHOT.jar"]