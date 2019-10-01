source $SCRATCH/POCL/setup.sh
module load cmake
TOPDIR=`pwd`

BUILDDIR=${TOPDIR}/build
INSTALLDIR=${TOPDIR}/install
SRCDIR=${TOPDIR}/src

PK_CXX=compute++
PK_CXXFLAGS="-O3  -no-serial-memop"

PK_CC=compute
PK_CFLAGS="-O3"
PK_OMP_ENABLE=""
MAKE="make -j 8"


