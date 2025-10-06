# sarif-converter GitHub Action

Run the `sarif-converter` (link)[https://gitlab.com/ignis-build/sarif-converter] CLI directly from your workflows using the published Docker image maintained in this repository. The Action converts SARIF files to other formats (HTML by default) without installing additional tooling.

## Workflow Usage

Add the Action to a workflow step. Provide the input SARIF file, desired output path, and (optionally) an output format.

```yaml
jobs:
  convert:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Convert SARIF to HTML
        uses: b-zurg/sarif-converter@v1
        with:
          sarif: reports/scan.sarif
          output: reports/scan.html
          type: html
```

### Inputs

- `sarif` (required): Path to the SARIF source file relative to the repository root.
- `output` (required): Output path relative to the repository root. Ensure the parent directory exists.
- `type` (optional, default `html`): Value passed to `sarif-converter --type`.
- `image` (optional, default `ghcr.io/buzurg/sarif-converter:latest`): Container image to run. Override to test a pre-release tag.

When referencing a custom image, confirm the tag exists in GHCR before sharing the workflow.

## Docker Image

The Action relies on a slim Docker image that packages the Linux `sarif-converter` binary. You can use the same image locally.

### Run Locally

Mount your project and execute the CLI as you would in CI:

```bash
docker run --rm -v "$PWD:/work" -w /work ghcr.io/buzurg/sarif-converter:latest --type html input.sarif output.html
```

Running without arguments prints the bundled help text:

```bash
docker run --rm ghcr.io/buzurg/sarif-converter:latest
```

### Build Locally

```bash
docker build -t sarif-converter:latest .
```

To pin a specific upstream release during the build, override the download URL:

```bash
docker build
```

### Image Details

- Linux x86_64 binary copied into a minimal scratch-based image.
- Analyzer tooling is not included; run your analyzer separately and feed its SARIF output into `sarif-converter`.

## Publishing & Versioning

- Label each pull request with `major`, `minor`, or `patch` (configurable in the workflow) so `pr-semver-bump` knows how to increment the semantic version.
- Include release notes in the pull request description; they are published with the GitHub release when the PR merges.
- When a labeled pull request merges into `main`, the `Release` workflow runs `pr-semver-bump` in bump mode to create the tag and GitHub release, then publishes `ghcr.io/<owner>/sarif-converter:latest` and `:<version>` using the computed version.
- Pull requests from this repository publish a preview image tagged `dev-pr-<number>` for manual testing.
- Pull requests from forks cannot push preview images because the token has read-only package scope.
