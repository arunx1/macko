FROM eclipse-temurin:17-jre-jammy

RUN apk update && apk upgrade
RUN apk add curl

RUN adduser -u 1000 -G users -h /home/wiremock -D wiremock

ARG WIREMOCK_VERSION

USER wiremock

WORKDIR /home/wiremock

RUN mkdir extensions

RUN  curl -fL "https://github.com/holomekc/wiremock/releases/download/$WIREMOCK_VERSION-ui/wiremock-jre8-standalone-$WIREMOCK_VERSION.jar" -o /home/wiremock/wiremock.jar

CMD java -XX:+PrintFlagsFinal $JAVA_OPTIONS -cp /home/wiremock/wiremock.jar:/home/extensions/* com.github.tomakehurst.wiremock.standalone.WireMockServerRunner


