# create build from source
FROM python:3 AS build

WORKDIR /build

RUN set -xe \
    && apt-get update -y \
    && apt-get install -y zip pandoc \
    && curl -L https://gitlab.com/dstftw/youtube-dl/-/archive/master/youtube-dl-master.zip -o youtube-dl-master.zip \
    && unzip youtube-dl-master.zip

WORKDIR /build/youtube-dl-master

RUN set -xe \
    && make

# add the build to the runtime container
FROM python:3-alpine

WORKDIR /data

# copy the build
COPY --from=build /build/youtube-dl-master/youtube-dl /usr/local/bin

# install dependencies
RUN set -xe \
    && chmod a+rx /usr/local/bin/youtube-dl \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk update --no-cache \
    && apk add --no-cache \
        ffmpeg \
        atomicparsley \
        ca-certificates \
        openssl

ENTRYPOINT ["youtube-dl"]
