#!/bin/bash

# The name of the dump file is in format: dtliving-bj.dingtalk.com:443-c53lulkbcv42e98cu44g.txt
# Example: 
# URL_PATH="/live_hp/f24890b6-a9ff-43a4-8ca0-b5ea243908cc_merge.m3u8?app_type=mac&auth_key=1632931414-0-0-81a082e0d301ba68ea96f904e97c3ada&cid=644805627fe01455c4a14cd86b3ab34f&token=90e2f0373b98b62e3a924d7b5b51df2fjFh4zpq5hCCwRH1eWSfDgA-xk-IEBb8El0e90Iy2R6GIfiOgqVogWBz9FNs4QVMPsNz2xXU3eByzs9oZnsk2-vcUZOEvx8du7RuvfMwx76w=&token2=c11e230f827d042be918d27e33a80db4o1q5RU8tM7YYXYavsaFLgikbUYs-zlpASUx3X-WrZc5_daOGHVPRf9BuERjfyyzDE1DCGGCfemeFkmlNmJfMWJGuDkVaK1RLwLUU5lNNkzQ&version=5.1.1"

if [[ "${#}" -lt 1 ]]; then
  echo "Usage: ./down.sh [URI]"
  exit 1
fi

URL_PATH="$1"

cd ~/tmp/live

AGENT='User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36 DingTalk(5.1.1-macOS-1697) nw'

curl -sS -H "$AGENT" "https://dtliving-bj.dingtalk.com${URL_PATH}" | grep '.ts' | sed 's#^#https://dtliving-bj.dingtalk.com/live_hp/#' > list.txt

cat /dev/null > out.txt
cat list.txt | while read line; do 
  name="${line##*/}"
  name="${name%%\?*}"
  echo "Downloading $name"

  if ! curl -sS -o "$name" "$line"; then
    echo "Downloading failed, exiting. "
    exit
  fi

  echo "file ""$name" >> out.txt
done