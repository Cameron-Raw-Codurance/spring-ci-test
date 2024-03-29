#FROM maven:3.8.1-openjdk-11-slim AS dev-build
#COPY src  /home/app/src
#COPY pom.xml /home/app
#RUN mvn -f /home/app/pom.xml clean package -Pdev
#
#FROM openjdk:11-jre-slim AS dev
#COPY --from=dev-build /home/app/target/*.jar /home/app/app.jar
#EXPOSE 8080
#ENTRYPOINT ["java", "-jar", "/home/app/app.jar"]

FROM maven:3.8.1-openjdk-11-slim AS prod-build
COPY src  /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package


FROM openjdk:11-jre-slim
COPY --from=prod-build /home/app/target/*.jar /home/app/app.jar
EXPOSE 80
ENTRYPOINT ["java", "-jar", "/home/app/app.jar"]
