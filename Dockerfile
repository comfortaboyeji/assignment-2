FROM alpine:3.22

RUN apk add --no-cache \
    bash \
    iputils \
    procps

WORKDIR /app

COPY app/diagnostic.sh /usr/local/bin/diagnostic
COPY app/health-check.sh /usr/local/bin/health-check

RUN chmod +x /usr/local/bin/diagnostic \
    /usr/local/bin/health-check

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD ["/usr/local/bin/health-check"]

ENTRYPOINT ["/usr/local/bin/diagnostic"]
