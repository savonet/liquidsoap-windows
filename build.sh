#!/bin/sh

OPAM_PKG=cry-windows,faad-windows,flac-windows,fdkaac-windows,portaudio-windows,gstreamer-windows,mad-windows,lame-windows,opus-windows,samplerate-windows,speex-windows,taglib-windows,theora-windows,vorbis-windows,winsvc-windows,ssl-windows,yojson-windows,duppy-windows,mm-windows,dtools-windows,pcre-windows,camomile-windows

LIQ_VERSION="1.3.3-beta4"

for system in win32 win64; do
  docker build -t savonet/liquidsoap-${system}-base -f Dockerfile.${system}-base .
  docker build -t savonet/liquidsoap-${system} --build-arg LIQ_VERSION=${LIQ_VERSION} --build-arg OPAM_PKG=${OPAM_PKG} -f Dockerfile.${system} .
  id=$(docker create savonet/liquidsoap-${system})
  docker cp $id:/tmp/liquidsoap-${LIQ_VERSION}-${system}.zip .
  docker rm -v $id
done
