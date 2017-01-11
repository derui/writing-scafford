FROM alpine:3.5

COPY entrypoint.sh /

RUN apk add --update --no-cache python3 git ca-certificates && \
    update-ca-certificates && \
    git clone https://github.com/jgraph/draw.io.git /draw-io && \
    chmod a+x /entrypoint.sh && \
    rm -rf /tmp/*

WORKDIR /draw-io/war
EXPOSE 8000

CMD /entrypoint.sh