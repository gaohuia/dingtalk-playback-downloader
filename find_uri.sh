#!/bin/sh

DIR=~/tmp/proxy

find_uri() {
  for file in "${DIR}/dtliving-bj.dingtalk.com:443"*; do 
    head -n 1 "$file" | grep '.m3u8' | cut -d ' ' -f 2
  done
}

find_uri