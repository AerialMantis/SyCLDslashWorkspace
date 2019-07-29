Kokkos WilsonDslash MiniApp Workspace
=====================================

This git repository contains the KokkosDslash
package and its dependencies

- `KokkosDslash` depends on `kokkos`, `googletest` and `qdp++`
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
the `--recursive` option to Git so that both `KokkosDslash` and
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

* `PK_CXX` - the C++ compiler
* `PK_CC`  - the C compiler
* `PK_CXXFLAGS` and `PK_CFLAGS` -- compiler flags
* `PK_LDFLAGS` and `PK_LIBS` -- linker flags

QDP++ (`qdpxx`) and the reference `cpp_wilson_dslash` packages
can be built with OpenMP threading. In order to use this feature
one needs to pass `--enable-openmp` to their configuration. 
This is set in the option `PK_OMP_ENABLE`. If you don't want openMP in these
packages, set the variable to an empty string.

The build_xxxx.sh files
-----------------------

The `build_xxxx.sh` files will build either `KokkosDslash` or its dependencies.
These files typically perform configuration by invoking `configure` (for 
`libxml2`, QDP++ (`qdpxx`) or CMake for `KokkosDslash`. Custom options can 
be set here, e.g. for the Kokkos to be built for CUDA etc, or for qdpxx
to use an installed libxml. There are some `build_kokkos_dslash.sh` script examples
for OpenMP builds in:

* `build_kokkos_dslash_knl_omp.sh` -- KNL build with Kokkos using OpenMP and specialized AVX512
* `build_kokkos_dslash_snb_omp.sh` -- CPU build (SandyBridge) using AVX2
* FIXME: add a GPU build example

Running The Mini-App:
=====================

Once building is complete the executables will be in `build/build_kokkos_dslash/tests`
Two executables are of primary interest: `test_kokkos_vnode` and `test_kokkos_vperf`.
The `test_kokkos_vnode` performs some unit testing and compares outputs against QDP++
equivalents. 

The performance test is `test_kokkos_vperf` which will first go through an exhaustive
tuning of block sizes, and then perform about 5-10 runs with the optimal block size.

For example, to run the test on an OpenMP build on an Intel Xeon Phi, Knights Landing
system with 68 cores, 272 threads one would do in the `tests/` directory:

```
export OMP_NUM_THREADS=272
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
./test_kokkos_vperf
```

Licensing and copyright
=======================

The Jefferson Lab License under which this workspace is distributed is in the file `LICENSE`
Licenses for dependencies are included in their source code and/or in the `LICENSES` directory.
 


