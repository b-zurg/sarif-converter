# sarif-converter Docker Image

This image bundles the standalone `sarif-converter` CLI so you can run the tool
without a manual install. It downloads the latest published Linux binary from
the upstream project at build time.

## Build

```bash
docker build -t sarif-converter:latest .
```

## Usage

Mount your SARIF input file and desired output location into the container and
run the CLI directly:

```bash
docker run --rm -v "$PWD:/work" -w /work sarif-converter:latest --type html intput.sarif output.json
```

The image defaults to showing the help text if no arguments are provided:

```bash
docker run --rm sarif-converter:latest
```

## Environment Variables

You can override the download URL at build time to pin a specific release:

```bash
docker build \
  --build-arg SARIF_CONVERTER_DOWNLOAD_URL=https://gitlab.com/ignis-build/sarif-converter/-/releases/v0.9.0/downloads/bin/sarif-converter-linux \
  -t sarif-converter:v0.9.0 .
```

## Notes

- The published binary targets Linux x86_64; this image uses a Debian base for
  compatibility with the glibc-linked release.
- The container does not include analyzers; run your analyzer of choice outside
  or inside the container and feed the generated SARIF file into `sarif-converter`.
