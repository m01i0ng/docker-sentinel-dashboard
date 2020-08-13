FROM openjdk:8-jre-alpine

ARG VERSION=1.7.2

ENV SERVER_PORT=8080 \
  SENTINEL_SERVER_DASHBOARD=localhost:8080 \
  PROJECT_NAME=sentinel-dashboard

EXPOSE ${SERVER_PORT}
WORKDIR /opt

RUN apk add --no-cache wget && \
wget -O sentinel-dashboard.jar https://github.com/alibaba/Sentinel/releases/download/${VERSION}/sentinel-dashboard-${VERSION}.jar && \
apk del wget
# COPY sentinel-dashboard.jar /opt/

RUN export JVAV_OPTS="-Dserver.port=${SERVER_PORT} -Dcsp.sentinel.dashboard.server=${SENTINEL_SERVER_DASHBOARD} -Dproject.name=${PROJECT_NAME} ${JAVA_OPTS}"

ENTRYPOINT [ "java",  "-jar", "/opt/sentinel-dashboard.jar" ]
