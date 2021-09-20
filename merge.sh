#!/bin/bash

ffmpeg -f concat -safe 0 -i out.txt -c copy out.mp4

