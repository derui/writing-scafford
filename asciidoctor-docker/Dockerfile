FROM alpine:3.4

RUN apk add --update --no-cache ruby asciidoctor ca-certificates && \
    update-ca-certificates && \
    gem install --no-ri --no-rdoc coderay guard guard-livereload && \
    gem cleanup && \
    rm -rf /tmp/*

WORKDIR /documents
VOLUME /documents

CMD ["/bin/sh"]