FROM fluent/fluentd:latest
USER root
RUN apk add ruby-dev
RUN gem install fluent-plugin-kafka --no-document