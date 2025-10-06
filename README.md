# sarif-converter GitHub Action

Run the [`sarif-converter`](https://gitlab.com/ignis-build/sarif-converter) CLI directly from your workflows using this Docker-based GitHub Action. It converts SARIF files to other formats (HTML by default) without installing additional tooling on the runner.

## Basic Usage

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

## CI Workflows

Two workflows ship with the repository and demonstrate how to automate publishing.

- **Pull requests** (`.github/workflows/test.yml`): Validates release metadata using [`pr-semver-bump`](https://github.com/jefflinse/pr-semver-bump) and pushes a preview image tagged `dev-pr-<number>` for quick testing. The workflow also exercises the published image against a sample SARIF file.
- **Releases** (`.github/workflows/release.yml`): When a labeled pull request merges to `main`, `pr-semver-bump` bumps the semantic version, creates the tag and GitHub release, and publishes `ghcr.io/<owner>/sarif-converter:latest` plus `:<version>`.

## Publishing & Versioning

- Label each pull request with `major`, `minor`, or `patch` so `pr-semver-bump` knows how to increment the semantic version.
- Include release notes in the pull request description; they are published with the GitHub release when the pull request merges.
- Preview images are available under `ghcr.io/<owner>/sarif-converter:dev-pr-<number>` until the branch merges.

## Local Docker Usage

Instructions for running or building the Docker image outside of GitHub Actions live in [`DOCKER.md`](DOCKER.md).
