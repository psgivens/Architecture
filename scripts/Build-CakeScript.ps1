#!/usr/bin/pwsh

docker run `
  -it --rm `
  --mount type=bind,source="$(pwd)",target='/src' `
  cakebuild/cake:2.1-sdk-mono `
  /src/build.sh

