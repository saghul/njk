#!/bin/bash

set -e

if [[ ! $(uname -s) == "Darwin" ]]; then
    echo "This script must be run in macOS"
    exit 1
fi

CROSSBUILD="saghul/crossbuild"

# Cleanup
rm -rf build out
mkdir out

# Build for macOS
make
mv build/njk-* out/
rm -rf build

# Build for Linux (x86_64)
docker run --rm -v $(pwd):/workdir ${CROSSBUILD} make
mv build/njk-* out/
rm -rf build

# Build for Linux (armhf)
docker run --rm -v $(pwd):/workdir -e CROSS_TRIPLE=arm-linux-gnueabihf ${CROSSBUILD} make
mv build/njk-* out/njk-linux-armhf
rm -rf build

# Build for Linux (arm64)
docker run --rm -v $(pwd):/workdir -e CROSS_TRIPLE=aarch64-linux-gnu ${CROSSBUILD} make
mv build/njk-* out/njk-linux-arm64
rm -rf build

# Done
echo "Done!"
ls -lh out/
