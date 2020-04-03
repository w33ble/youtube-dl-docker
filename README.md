# youtube-dl in Docker

Docker image for [youtube-dl](https://ytdl-org.github.io/youtube-dl/), built from source.

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/w33ble/youtube-dl-web/master/LICENSE)
[![Project Status](https://img.shields.io/badge/status-stable-limgreen.svg)](https://nodejs.org/api/documentation.html#documentation_stability_index)

## Docker setup

Install docker: https://docs.docker.com/engine/installation/

Install docker compose: https://docs.docker.com/compose/install/

Docker documentation: https://docs.docker.com/

## Usage

```
docker run -i --rm -v "$(pwd)":/data w33ble/youtube-dl [options] <url to download>
```

If you have issues with file permissions, you may need to add some flags for the user and group, like so:

```
docker run -i --rm -u $(id -u):$(id -g) -v "$(pwd)":/data w33ble/youtube-dl [options] <url to download>
```

This will download the video or audio from the provided URL into the current working path. You can pass in any command line arguments that [youtube-dl accepts](https://github.com/ytdl-org/youtube-dl/blob/master/README.md#readme). As an example, you can specify your desired format like so:

```
docker run -i --rm -u $(id -u):$(id -g) -v "$(pwd)":/data w33ble/youtube-dl -f "bestvideo[ext=mp4][heigh  t<=1080]+bestaudio[ext=m4a]/bestvideo+bestaudio/best" <url to download>
```

### Building locally

```
docker build -t youtube-dl .
```
