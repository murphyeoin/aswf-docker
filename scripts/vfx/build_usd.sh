#!/usr/bin/env bash
set -ex

pip install jinja2 PyOpenGL

if [ ! -f $DOWNLOADS_DIR/usd-${USD_VERSION}.tar.gz ]; then
     curl --location https://github.com/PixarAnimationStudios/USD/archive/v${USD_VERSION}.tar.gz -o $DOWNLOADS_DIR/usd-${USD_VERSION}.tar.gz
fi

tar -zxf $DOWNLOADS_DIR/usd-${USD_VERSION}.tar.gz
cd USD-${USD_VERSION}

mkdir build
cd build

cmake \
    -DCMAKE_INSTALL_PREFIX=${ASWF_INSTALL_PREFIX} \
    -DOPENEXR_LOCATION=${ASWF_INSTALL_PREFIX} \
    -DCPPUNIT_LOCATION=${ASWF_INSTALL_PREFIX} \
    -DBLOSC_LOCATION=${ASWF_INSTALL_PREFIX} \
    -DTBB_LOCATION=${ASWF_INSTALL_PREFIX} \
    -DILMBASE_LOCATION=${ASWF_INSTALL_PREFIX} \
    -DPXR_BUILD_TESTS=OFF \
    -DUSD_ROOT_DIR=$ASWF_INSTALL_PREFIX \
    -DPXR_BUILD_ALEMBIC_PLUGIN=OFF \ # @TODO: Fix needed for HDF5 not found
    -DPXR_BUILD_MAYA_PLUGIN=FALSE \
    ..

make -j64
make install

cd ../..

rm -rf USD-${USD_VERSION}
