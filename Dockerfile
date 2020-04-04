# create build from source
FROM python:3 AS build

WORKDIR /build

RUN set -xe \
    && apt-get update -y \
    && apt-get install -y zip pandoc \
    && curl -L https://github.com/ytdl-org/youtube-dl/archive/master.zip -o youtube-dl-master.zip \
    && unzip youtube-dl-master.zip

WORKDIR /build/youtube-dl-master

RUN set -xe \
    && make

# add the build to the web container
FROM python:3-alpine

WORKDIR /data

# copy the build
COPY --from=build /build/youtube-dl-master/youtube-dl /usr/local/bin

# install dependencies
RUN set -xe \
    && chmod a+rx /usr/local/bin/youtube-dl \
    && apk add --no-cache ca-certificates \
                          ffmpeg \
                          openssl \
                          python3 \
    && ln -s /usr/bin/python3 /usr/bin/python

ENTRYPOINT ["youtube-dl"]
