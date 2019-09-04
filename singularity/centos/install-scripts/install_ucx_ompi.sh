#!/bin/bash
# Install communication runtimes and MPI libraries

set -ex

source /mnt/shared/setenv

INSTALL_PREFIX=/opt

mkdir -p /tmp/mpi
cd /tmp/mpi

# UCX 1.5.0
UCX_VERSION="1.6.0"
UCX_PATH="${INSTALL_PREFIX}/ucx-${UCX_VERSION}"
wget https://github.com/openucx/ucx/releases/download/v${UCX_VERSION}/ucx-1.6.0.tar.gz
tar -xvf ucx-${UCX_VERSION}.tar.gz
cd ucx-${UCX_VERSION}
./contrib/configure-release --prefix=${UCX_PATH} && make -j && make install
cd ..

# OpenMPI 4.0.1
OMPI_VERSION="4.0.1"
OMPI_PATH="${INSTALL_PREFIX}/openmpi-${OMPI_VERSION}"
wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-${OMPI_VERSION}.tar.gz
tar -xvf openmpi-${OMPI_VERSION}.tar.gz
cd openmpi-${OMPI_VERSION}
./configure --prefix=${OMPI_PATH} --with-ucx=${UCX_PATH} --enable-mpirun-prefix-by-default && make -j && make install
cd ..

cd && rm -rf /tmp/mpi

ompi_path="export PATH=${OMPI_PATH}/bin:\$PATH
export LD_LIBRARY_PATH=${OMPI_PATH}/lib:\$LD_LIBRARY_PATH
export MANPATH=${OMPI_PATH}/share/man:\$MANPATH
export MPI_BIN=${OMPI_PATH}/bin
export MPI_INCLUDE=${OMPI_PATH}/include
export MPI_LIB=${OMPI_PATH}/lib
export MPI_MAN=${OMPI_PATH}/share/man
export MPI_HOME=${OMPI_PATH}"

echo -e "$ompi_path" >> /mnt/shared/setenv

source /mnt/shared/setenv
