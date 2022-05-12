FROM amazoncorretto:17-alpine3.15

WORKDIR /app

ADD ./account-microservice-*.jar account-microservice.jar

ENV SERVICE_NAME="account"
RUN addgroup --gid 1001 -S $SERVICE_NAME && \
    adduser -G $SERVICE_NAME --shell /bin/false --disabled-password -H --uid 1001 $SERVICE_NAME

EXPOSE 8074

USER $SERVICE_NAME

ENTRYPOINT ["java", "-jar", "account-microservice.jar"]

