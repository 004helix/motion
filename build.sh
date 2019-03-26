#!/bin/sh

set -ex

cd /opt
apk --no-cache add tini libmicrohttpd libjpeg-turbo ffmpeg-libs sqlite-libs mosquitto-clients
apk --no-cache add git gcc make libc-dev libmicrohttpd-dev libjpeg-turbo-dev ffmpeg-dev sqlite-dev autoconf automake

git clone --depth 1 https://github.com/Motion-Project/motion.git src && cd src
sed -i netcam_rtsp.c -e '/"rtsp_transport"/i \        av_dict_set(&rtsp_data->opts, "fflags", "nobuffer", 0);'
autoreconf -fiv && ./configure --prefix /usr/local && make && make install
cd /opt && rm -rf src

apk --no-cache del git gcc make libc-dev libmicrohttpd-dev libjpeg-turbo-dev ffmpeg-dev sqlite-dev autoconf automake
