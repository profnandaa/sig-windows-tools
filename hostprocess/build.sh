#!/bin/bash

repository=${repository:-"sigwindowstools"}
flannelVersion=${flannelVersion:-"v0.14.0"}
calicoVersion=${calicoVersion:-"v3.23.0"}

SCRIPTROOT=$(dirname "${BASH_SOURCE[0]}")
pushd $SCRIPTROOT/flannel
./build.sh -r $repository --flannelVersion $flannelVersion
popd
pushd $SCRIPTROOT/calico
./build.sh -r $repository --calicoVersion $calicoVersion
popd

declare -a proxyVersions=("v1.22.9" "v1.23.6" "v1.24.0")

# Read the array values with space
for proxyVersion in "${proxyVersions[@]}"; do
  pushd $SCRIPTROOT/flannel
  ./build.sh -r $repository --proxyVersion $proxyVersion
  popd
  pushd $SCRIPTROOT/calico
  ./build.sh -r $repository --proxyVersion $proxyVersion
  popd
done
