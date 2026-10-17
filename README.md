# Assignment 2 — Dockerized Diagnostic CLI

## Overview

A Bash-based Linux diagnostic tool packaged as a Docker image.

## Project Structure

- `app/diagnostic.sh` — Main diagnostic application
- `app/health-check.sh` — Container health check
- `Dockerfile` — Image build instructions
- `compose.yaml` — Docker Compose configuration
- `.dockerignore` — Excluded build files
- `test.sh` — Automated tests
- `grade.sh` — Grading helper

## Requirements

- Docker Engine
- Docker Compose plugin
- Terminal or command-line interface

## Build

```bash
docker build -t diagnostic-tool .
```

## Run

```bash
docker run --rm diagnostic-tool help
docker run --rm diagnostic-tool system
docker run --rm diagnostic-tool disk
docker run --rm diagnostic-tool network google.com
```

## Docker Compose

```bash
docker compose run --rm diagnostic help
docker compose run --rm diagnostic system
docker compose run --rm diagnostic disk
docker compose run --rm diagnostic network google.com
```

## Testing

```bash
bash test.sh
bash grade.sh
```

## Exit Codes

- `0` — Success
- `1` — Operational/runtime failure
- `2` — Invalid command or input
