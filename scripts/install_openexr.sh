#!/usr/bin/env bash

set -ex

OPENEXR_VERSION="$1"

git clone https://github.com/openexr/openexr.git
cd openexr

if [ "$OPENEXR_VERSION" != "latest" ]; then
    git checkout tags/v${OPENEXR_VERSION} -b v${OPENEXR_VERSION}
fi

mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
      ../.
make -j4
make install

cd ../..
rm -rf openexr