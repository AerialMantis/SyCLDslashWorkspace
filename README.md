SyCL WilsonDslash MiniApp Workspace
=====================================

This git repository contains the SyCLDslash
package and its dependencies

- `SyCLDslash` depends on `googletest` and `qdp++`
- `qdp++` in turn depends on other USQCD libraries as
submodules, and `libxml2`.

Since libxml2 has developed a lot we include an older source
tree of libxml2 with this workspace that is known to compile
with our scripts. Users may wish to use an installed libxml2
on most systems one needs to install the developer package
(e.g. `libxml2-dev`) containing static libraries,

Checking out this repository
============================

It is highly recommended that this library be checked out using
the `--recursive` option to Git so that both `SyCLDslash` and
`qdp++` (aka `qdpxx`) check out their required submodules

Building the Mini Apps
======================

This is a single node mini-app which requires in essence just a 
C++ compiler in addition to the sources. A straighforward build
for CPU OpenMP targets would involve:

a) setting up the `env.sh` file with compiler specifics
b) editing the `build_xxx.sh` scripts 

The `build_all.sh` script will call in sequence the necessary
builds for `libxml2`, followed by `qdpxx` followed by the mini-app.

The env.sh file
---------------

All the build scripts include the `env.sh` file. This can set some 
package related (`PK_XXXXX` ) env variables to specify paths, load
modules, and set compiler / linker variables. In addition the file
specifies locations of the source, build and install directories. 
To adapt to a new system typically the following would need to be set:

* `PK_CXX` - the C++/SyCL compiler
* `PK_CC`  - the C compiler
* `PK_CXXFLAGS` and `PK_CFLAGS` -- compiler flags
* `PK_LDFLAGS` and `PK_LIBS` -- linker flags

QDP++ (`qdpxx`) be built with OpenMP threading. In order to use this feature
one needs to pass `--enable-openmp` to their configuration. 
This is set in the option `PK_OMP_ENABLE`. If you don't want openMP in these
packages, set the variable to an empty string.

The build_xxxx.sh files
-----------------------

The `build_xxxx.sh` files will build either `SyCLDslash` or its dependencies.
These files typically perform configuration by invoking `configure` (for 
`libxml2`, QDP++ (`qdpxx`) or CMake for `SyCLDslash`. Custom options can 
be set here, e.g. for the Kokkos to be built for CUDA etc, or for qdpxx
to use an installed libxml. There are some `build_sycl_dslash.sh` script examples

CMake Options
-------------

* `MG_FORTRNALIKE_COMPLEX` -- Whether Vectorized Complex should be Fortran like (ON=RIRIRIRI) or not (OFF=RRRRRIIII)

Running The Mini-App:
=====================

Once building is complete the executables will be in `build/build_sycl_dslash/tests`.

* `test_vectype_sycl` -- tests the workings of the vector type
* `test_vnode_sycl`   -- tests the working of the Virtual Node Shift permutes


Licensing and copyright
=======================

The Jefferson Lab License under which this workspace is distributed is in the file `LICENSE`
Licenses for dependencies are included in their source code and/or in the `LICENSES` directory.
 


