FROM alpine:3.4

RUN apk add --update --no-cache ruby asciidoctor ca-certificates rsync && \
    update-ca-certificates && \
    apk add --no-cache --virtual build-dependencies build-base libffi-dev ruby-dev && \
    gem install --no-ri --no-rdoc coderay guard io-console guard-shell && \
    gem cleanup && \
    mkdir /mirror && \
    apk del build-dependencies && \
    rm -rf /tmp/*

WORKDIR /documents
VOLUME /documents

ADD watcher.rb /watcher.rb

CMD ["/bin/sh","-c","trap 'exit 0' INT; tail -f /dev/null"]