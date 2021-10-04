FROM maven:3-openjdk-11 as build
WORKDIR /src
ADD . ./
RUN mvn clean install

FROM openjdk:11-jre
WORKDIR /app
COPY --from=build /src/target/*.jar ./
ENTRYPOINT java -jar ./*.jar

ENV DB_HOST db
ENV DB_PORT 3306
ENV DB_NAME urlshortener
ENV DB_USER urlshortener
ENV DB_PASS urlshortener
