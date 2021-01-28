Table of Contents
-----------------

- [Table of Contents](#table-of-contents)
- [Description](#description)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Workloads](#workloads)
  - [1. P-CLHT](#1-p-clht)
    - [Apply Patch](#apply-patch)
    - [Build](#build)
    - [Run](#run)
    - [Generate Patch (optional)](#generate-patch-optional)
  - [2. memcached-pmem](#2-memcached-pmem)
    - [Apply Patch](#apply-patch-1)
    - [Build](#build-1)
    - [Run](#run-1)
    - [Generate Patch (optional)](#generate-patch-optional-1)
  - [3. CCEH](#3-cceh)
    - [Apply Patch](#apply-patch-2)
    - [Build](#build-2)
    - [Run](#run-2)
    - [Generate Patch (optional)](#generate-patch-optional-2)
  - [4. FAST_FAIR](#4-fast_fair)
    - [Apply Patch](#apply-patch-3)
    - [Build](#build-3)
    - [Run](#run-3)
    - [Generate Patch (optional)](#generate-patch-optional-3)
  - [5. Clevel Hashing](#5-clevel-hashing)
    - [Apply Patch](#apply-patch-4)
    - [Build](#build-4)
    - [Run](#run-4)
    - [Generate Patch (optional)](#generate-patch-optional-4)

## Description

This repo contains the workloads for PMRace with corresponding patches.

## Prerequisites

Install required dependencies (for these PM workloads).

```sh
    $ sudo apt-get install build-essential cmake libboost-all-dev libpapi-dev default-jdk \
        libtbb-dev libjemalloc-dev libevent-dev
```

## Setup

Update submodules

```sh
    $ git submodule init && git submodule update --progress
```

Set the environment variables, e.g., `LLVM_DIR` and `PMRACE_DIR`, which are configured by the "env.sh" of artifacts.

## Workloads

### 1. P-CLHT

#### Apply Patch

Run the following commands to apply the required patch.

```sh
    $ cd RECIPE
    $ ../patches/apply_patches.sh RECIPE
```

#### Build

Run the following commands to build.

```sh
    $ mkdir -p P-CLHT/build
    $ cd P-CLHT/build
    $ cmake -DCMAKE_BUILD_TYPE=Debug ..
    $ make
```

#### Run

To run the debugging tool.

```sh
    $ $PMRACE_DIR/scripts/clear.sh                   # clear the results of previous tests
    $ python3 $PMRACE_DIR/scripts/fuzz.py -e p-clht -d ./CMakeFiles/driver.dir -p $PMRACE_DIR/deps/pmdk -s /path/to/seeds
```

#### Generate Patch (optional)

To export patches (for RECIPE).

```sh
    $ ../patches/gen_patches.sh RECIPE
```

### 2. memcached-pmem

#### Apply Patch

Run the following commands to apply the required patch.

```sh
    $ cd memcached-pmem
    $ ../patches/apply_patches.sh memcached
```

#### Build

Run the following commands to build.

```sh
    $ autoreconf
    $ CC=clang CXX=clang++ ./configure --enable-pslab --enable-pmrace
    $ make
```

#### Run

To run the debugging tool.

```sh
    $ $PMRACE_DIR/scripts/clear.sh                   # clear the results of previous tests
    $ python3 $PMRACE_DIR/scripts/fuzz.py -e memcached -d ./ -p $PMRACE_DIR/deps/pmdk -s /path/to/seeds
```

#### Generate Patch (optional)

To export patches (for memcached-pmem).

```sh
    $ ../patches/gen_patches.sh memcached
```

### 3. CCEH

#### Apply Patch

Run the following commands to apply the required patch.

```sh
    $ cd CCEH/
    $ ../patches/apply_patches.sh CCEH
```

#### Build

Run the following commands to build.

```sh
    $ cd CCEH-PMDK/
    $ make
```

#### Run

Run the following commands to test `CCEH`.

```sh
    $ $PMRACE_DIR/scripts/clear.sh                   # clear the results of previous tests
    $ python3 $PMRACE_DIR/scripts/fuzz.py -e cceh -d ./ -p $PMRACE_DIR/deps/pmdk -s /path/to/seeds
```

#### Generate Patch (optional)

Run the following commands to generate the patch.

```sh
    $ ../patches/gen_patches.sh CCEH
```

### 4. FAST_FAIR

#### Apply Patch

Run the following commands to apply the required patch.

```sh
    $ cd FAST_FAIR/
    $ ../patches/apply_patches.sh FAST_FAIR
```

#### Build

Run the following commands to build.

```sh
    $ cd concurrent_pmdk/
    $ make
```

#### Run

Run the following commands to test `FAST_FAIR`.

```sh
    $ $PMRACE_DIR/scripts/clear.sh                   # clear the results of previous tests
    $ python3 $PMRACE_DIR/scripts/fuzz.py -e fast-fair -d ./ -p $PMRACE_DIR/deps/pmdk -s /path/to/seeds
```

#### Generate Patch (optional)

Run the following commands to generate the patch.

```sh
    $ ../patches/gen_patches.sh FAST_FAIR
```

### 5. Clevel Hashing

#### Apply Patch

Run the following commands to apply the required patch.

```sh
    $ cd Clevel-Hashing/
    $ ../patches/apply_patches.sh clevel
```

#### Build

Run the following commands to build.

```sh
    $ mkdir build
    $ cd build
    $ cmake -DENABLE_PMRACE=ON ..
    $ make -j16
    $ cd tests
```

#### Run

Run the following commands to test `clevel hashing`.

```sh
    $ $PMRACE_DIR/scripts/clear.sh                   # clear the results of previous tests
    $ python3 $PMRACE_DIR/scripts/fuzz.py -e clevel -d ./CMakeFiles/clevel_hash_ycsb.dir -p $PMRACE_DIR/deps/pmdk -s /path/to/seeds
```

#### Generate Patch (optional)

Run the following commands to generate the patch.

```sh
    $ ../patches/gen_patches.sh clevel
```
