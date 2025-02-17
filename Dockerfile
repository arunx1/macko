# BUILD

FROM gradle:8-jdk17 AS builder

WORKDIR /workdir

RUN git clone https://github.com/arunx1/macko.git .

RUN sed -i /Xmx3g/d gradle.properties

RUN ./gradlew shadowJar

# RUN

FROM eclipse-temurin:17-jre

LABEL maintainer="Arun Kumar"

WORKDIR /home/wiremock

COPY --from=builder /workdir/build/libs/*.jar /var/wiremock/lib/wiremock-standalone.jar

COPY docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]

# Init WireMock files structure
RUN mkdir -p /home/wiremock/mappings && \
	mkdir -p /home/wiremock/__files && \
	mkdir -p /var/wiremock/extensions

EXPOSE 8080 8443

HEALTHCHECK --start-period=5s --start-interval=100ms CMD curl -f http://localhost:8080/__admin/health || exit 1

ENTRYPOINT ["/docker-entrypoint.sh"]
