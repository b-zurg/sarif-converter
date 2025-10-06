ARG SARIF_CONVERTER_DOWNLOAD_URL="https://gitlab.com/ignis-build/sarif-converter/-/releases/v0.9.4/downloads/bin/sarif-converter-linux-amd64"
# ---- Stage 1: downloader ----
FROM alpine:3.20 AS downloader
RUN apk add --no-cache wget
RUN wget -O /sarif-converter https://gitlab.com/ignis-build/sarif-converter/-/releases/v0.9.4/downloads/bin/sarif-converter-linux-amd64 \
    && chmod +x /sarif-converter

# ---- Stage 2: final image ----
FROM scratch
COPY --from=downloader /sarif-converter /usr/local/bin/sarif-converter
ENTRYPOINT ["/usr/local/bin/sarif-converter"]
