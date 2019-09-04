## Benchmarking Intel optimized Tensorflow w/ Horovod using Singularity Containers
Setup to run deep learning distributed training with intel-tensorflow and Horovod using Singularity Containers


## << Documentation is WIP  >>

#### Step 1: Setup cluster and Login into a compute node
Make sure you have a cluster with password-less ssh among all nodes and it has NFS

#### Step 2: Setup the compute node

```
#install the pre-req
sudo yum install -y git tmux

#Clone the repo
cd ~
git clone https://github.com/ravi9/dl-containers.git
cd ~/dl-containers/

# Start a tmux or screen session, as the installations take about 80min !
# Most of the time taken is building GCC8.2 twice: on the host and inside the container.
tmux

# Inside the tmux window pane, start the installations, pass an argument for appropriate MPI. <intelmpi|openmpi>
time sudo sh -c "./setup-host-and-build-container.sh intelmpi 2>&1 | tee /tmp/2-setup-host-and-build-container.log"

```

#### Step 3: Run Benchmarks
Run `benchmark-scripts/run-tf-sing-ucx-openmpi.sh` script. See below for usage
```
cd ~/dl-containers/benchmark-scripts
#usage: ./run-tf-sing-ucx-openmpi.sh <NUM_NODES> <WORKERS_PER_SOCKET> <batch_size> <fabric(ib,sock)>

# Following examples are assuming a 2-socket server
# To run 4nodes, 8 workers, with infiniband
./run-tf-sing-ucx-openmpi.sh 4 1 64 ib

# To run 2nodes, 4 workers, with Sockets(Ethernet)
./run-tf-sing-ucx-openmpi.sh 2 1 64 sock
```

### References:
- [https://github.com/jithinjosepkl/azhpc-images/](https://github.com/jithinjosepkl/azhpc-images/)
