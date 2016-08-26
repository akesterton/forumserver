FROM java:8u92-jre-alpine

RUN useradd -ms /bin/bash forumuser
USER forumuser
WORKDIR /home/forumuser

SERVER_BIN_DIR=https://github.com/akesterton/forumserver/target

ENV VERTICLE_FILE game-service-1.0.0-SNAPSHOT-fat.jar
ENV VERTICLE_HOME /usr/verticles

EXPOSE 8080 9001 9002

RUN curl -L $SERVER_BIN_DIR/$VERTICLE_FILE -o $VERTICLE_HOME/$VERTICLE_FILE

# COPY src/main/resources/ $VERTICLE_HOME/

RUN chmod 777 $VERTICLE_HOME

WORKDIR $VERTICLE_HOME

ENTRYPOINT ["sh", "-c"]

CMD ["java -jar $VERTICLE_FILE -conf config.json -cp . -cluster -Dvertx.metrics.options.enabled=true -Dvertx.metrics.options.jmxEnabled=true"]
