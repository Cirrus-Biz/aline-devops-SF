FROM amazoncorretto:17-alpine3.15

WORKDIR /app

ADD ./target/underwriter-microservice-*.jar underwriter-microservice.jar

ENV SERVICE_NAME="underwriter"
RUN addgroup --gid 1001 -S $SERVICE_NAME && \
    adduser -G $SERVICE_NAME --shell /bin/false --disabled-password -H --uid 1001 $SERVICE_NAME

EXPOSE 8071

USER $SERVICE_NAME
 
ENTRYPOINT ["java", "-jar", "underwriter-microservice.jar"]

