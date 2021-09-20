#!/bin/sh

uri=$(./find_uri.sh)
if [[ "$uri" != "" ]]; then
  ./down.sh "$uri"
else
  echo "Not able to find the URI nesseary to download the video. "
fi