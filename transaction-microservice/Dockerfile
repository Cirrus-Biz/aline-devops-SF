FROM amazoncorretto:17-alpine3.15

WORKDIR /app

ADD ./target/transaction-microservice-*.jar transaction-microservice.jar

ENV SERVICE_NAME="transaction"
RUN addgroup --gid 1001 -S $SERVICE_NAME && \
    adduser -G $SERVICE_NAME --shell /bin/false --disabled-password -H --uid 1001 $SERVICE_NAME

EXPOSE 8073

USER $SERVICE_NAME

ENTRYPOINT ["java", "-jar", "transaction-microservice.jar"]
