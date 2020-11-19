# youtube-dl in Docker

Docker image for [youtube-dl](https://ytdl-org.github.io/youtube-dl/), built from source. Available on [Docker Hub](https://hub.docker.com/r/w33ble/youtube-dl).

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/w33ble/youtube-dl-web/master/LICENSE)
[![Project Status](https://img.shields.io/badge/status-stable-limgreen.svg)](https://nodejs.org/api/documentation.html#documentation_stability_index)

## Docker setup

Install docker: https://docs.docker.com/engine/installation/

Install docker compose: https://docs.docker.com/compose/install/

Docker documentation: https://docs.docker.com/

## Usage

```sh
docker run -i --rm -v "$(pwd)":/data w33ble/youtube-dl [options] <url to download>
```

If you have issues with file permissions, you may need to add some flags for the user and group, like so:

```sh
docker run -i --rm -u $(id -u):$(id -g) -v "$(pwd)":/data w33ble/youtube-dl [options] <url to download>
```

This will download the video or audio from the provided URL into the current working path. You can pass in any command line arguments that [youtube-dl accepts](https://github.com/ytdl-org/youtube-dl/blob/master/README.md#readme). As an example, you can specify your desired format like so:

```sh
docker run -i --rm -u $(id -u):$(id -g) -v "$(pwd)":/data w33ble/youtube-dl -f "bestvideo[ext=mp4][height<=1080]+bestaudio[ext=m4a]/bestvideo+bestaudio/best" <url to download>
```

### Building locally

```sh
docker build -t youtube-dl .
```

## Manual trigger

The action here can be trigger manually in addition to running automatically every day. To do so, create a personal access token with the `repo` permission and use the follow curl command:

```sh
curl -H "Accept: application/vnd.github.everest-preview+json" \
    -H "Authorization: token TOKEN_HERE" \
    --request POST \
    --data '{"event_type": "manual-trigger"}' \
    https://api.github.com/repos/w33ble/youtube-dl-docker/dispatches
```
