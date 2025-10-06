# sarif-converter Docker Image

The GitHub Action relies on a slim Docker image that packages the Linux `sarif-converter` binary. You can reuse the same image locally for manual conversions or testing.

## Run Locally

Mount your project and execute the CLI as you would in CI:

```bash
docker run --rm -v "$PWD:/work" -w /work ghcr.io/buzurg/sarif-converter:latest --type html input.sarif output.html
```

Running without arguments prints the bundled help text:

```bash
docker run --rm ghcr.io/buzurg/sarif-converter:latest
```

## Build Locally

```bash
docker build -t sarif-converter:latest .
```

To pin a specific upstream release during the build, override the download URL:

```bash
docker build
```

## Image Details

- Linux x86_64 binary copied into a minimal scratch-based image.
- Analyzer tooling is not included; run your analyzer separately and feed its SARIF output into `sarif-converter`.
