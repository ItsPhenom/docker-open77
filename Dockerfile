FROM debian:bookworm-slim AS builder
ARG VERSION
WORKDIR /app
RUN true \
    && apt-get update && apt-get install -y --no-install-recommends curl ca-certificates \
    && curl -so server.tar.gz https://cdn.open77.dev/server/${VERSION}/open77-server-${VERSION}-linux-x64.tar.gz \
    && tar xzf server.tar.gz && rm server.tar.gz \
    && mkdir settings \
    && chown -R 65532:65532 /app \
    && true


FROM gcr.io/distroless/cc-debian13:nonroot
ARG VERSION \
    BUILD_DATE \
    REVISION

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
LABEL org.opencontainers.image.title="OPEN//77 Server" \
      org.opencontainers.image.description="" \
      org.opencontainers.image.authors="Nicolas Graf <nicolas.j.graf@gmail.com>" \
      org.opencontainers.image.vendor="" \
      org.opencontainers.image.licenses="" \
      org.opencontainers.image.version=${VERSION} \
      org.opencontainers.image.created=${BUILD_DATE} \
      org.opencontainers.image.revision=${REVISION}

WORKDIR /app
COPY --from=builder --chown=65532:65532 /app /app

EXPOSE 11778/udp
EXPOSE 11779/tcp
EXPOSE 11780/tcp

USER nonroot

ENTRYPOINT ["./Open77.Server"]
CMD ["--config", "/app/settings/server.jsonc"]
