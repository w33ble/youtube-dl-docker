# youtube-dl in Docker

Docker image for [youtube-dl](http://rg3.github.io/youtube-dl/), built from source.

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/w33ble/youtube-dl-web/master/LICENSE)
[![Project Status](https://img.shields.io/badge/status-stable-limgreen.svg)](https://nodejs.org/api/documentation.html#documentation_stability_index)

## Docker setup

Install docker: https://docs.docker.com/engine/installation/

Install docker compose: https://docs.docker.com/compose/install/

Docker documentation: https://docs.docker.com/

## Usage

```
docker run --rm -v $(pwd):/data youtube-dl [options] <url to download>
```

This will download the video or audio from the provided URL into the current working path. You can pass in any command line arguments that [youtube-dl accepts](https://github.com/ytdl-org/youtube-dl/blob/master/README.md#readme).

### Building locally

```
docker build -t youtube-dl .
```
