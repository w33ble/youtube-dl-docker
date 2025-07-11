# create build from source
FROM python:3 AS build

WORKDIR /build

RUN set -xe \
    && apt-get update -y \
    && apt-get install -y zip pandoc \
    && curl -L https://github.com/yt-dlp/yt-dlp/archive/refs/heads/master.zip -o youtube-dlp-master.zip \
    && unzip youtube-dlp-master.zip

WORKDIR /build/yt-dlp-master

RUN set -xe \
    && make yt-dlp

# add the build to the runtime container
FROM python:3-alpine

WORKDIR /data

# allow yt-dlp to write to /.cache
RUN mkdir /.cache && chmod 777 /.cache

# copy the build
COPY --from=build /build/yt-dlp-master/yt-dlp /usr/local/bin

# install dependencies
RUN set -xe \
    && chmod a+rx /usr/local/bin/yt-dlp \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk update --no-cache \
    && apk add --no-cache \
        ffmpeg \
        atomicparsley \
        ca-certificates \
        openssl
RUN pip3 install 'requests>=2.31.0'

ENTRYPOINT ["yt-dlp"]

