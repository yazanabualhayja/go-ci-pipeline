# Go Service with a CI Pipeline

![CI](https://github.com/yazanabualhayja/go-ci-pipeline/actions/workflows/ci.yml/badge.svg)

A minimal **Go** web service, packaged with a **multi-stage Docker build** and shipped automatically by a **GitHub Actions** pipeline to the **GitHub Container Registry (GHCR)**.

## What it shows

- **Multi-stage build** – compiles a static binary in a `golang` image, then copies only that binary into an empty `scratch` image. The final image is just a few MB with no OS, shell or package manager.
- **Continuous integration** – every push to `main` triggers the pipeline (it can also be run manually).
- **Automated smoke test** – the pipeline starts the container and checks it responds with `curl` before anything is published.
- **Image publishing** – images are pushed to GHCR tagged both `latest` and with the commit SHA, so every build is traceable.

## Pipeline

```
push to main ─▶ checkout ─▶ docker build ─▶ run + curl smoke test ─▶ tag (latest, sha) ─▶ push to GHCR
```

## Run it locally

```bash
docker build -t gostage .
docker run --rm -p 8080:8080 gostage
curl http://localhost:8080
# Hello from Go, built with multi-stage!
```

Or pull the image the pipeline built:

```bash
docker run --rm -p 8080:8080 ghcr.io/yazanabualhayja/go-ci-pipeline:latest
```

## Tech

Go 1.22 · Docker (multi-stage, scratch) · GitHub Actions · GitHub Container Registry
