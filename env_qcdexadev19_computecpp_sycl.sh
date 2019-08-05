. /usr/share/modules/init/bash
module load computecpp
module load cmake-3.13.4

TOPDIR=`pwd`

BUILDDIR=${TOPDIR}/build
INSTALLDIR=${TOPDIR}/install
SRCDIR=${TOPDIR}/src

PK_CXX=compute++
PK_CXXFLAGS="-O3"

PK_CC=compute
PK_CFLAGS="-O3"
PK_OMP_ENABLE=""
MAKE="make -j 8"


