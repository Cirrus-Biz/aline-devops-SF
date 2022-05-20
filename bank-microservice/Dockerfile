FROM amazoncorretto:17-alpine3.15

WORKDIR /app

ADD ./target/bank-microservice-*.jar bank-microservice.jar

ENV SERVICE_NAME="bank"
RUN addgroup --gid 1001 -S $SERVICE_NAME && \
    adduser -G $SERVICE_NAME --shell /bin/false --disabled-password -H --uid 1001 $SERVICE_NAME

EXPOSE 8072

USER $SERVICE_NAME

ENTRYPOINT ["java", "-jar", "bank-microservice.jar"]
