FROM alpine:3.4

RUN apk add --update --no-cache ruby asciidoctor ca-certificates && \
    update-ca-certificates && \
    apk add --no-cache --virtual build-dependencies build-base libffi-dev ruby-dev && \
    gem install --no-ri --no-rdoc coderay guard && \
    gem cleanup && \
    apk del build-dependencies && \
    rm -rf /tmp/*

WORKDIR /documents
VOLUME /documents

CMD ["/bin/sh"]