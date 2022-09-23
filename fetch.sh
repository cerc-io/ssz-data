#!/bin/bash

HOST=localhost:5052

SLOT=$1

while [ ! -z "$SLOT" ]; do
  rm -rf $SLOT
  mkdir -p $SLOT
  cd $SLOT
  echo "Fetching http://$HOST/eth/v2/debug/beacon/states/$SLOT ..."
  wget -O beacon-state.ssz -q --header='Accept: application/octet-stream' http://$HOST/eth/v2/debug/beacon/states/$SLOT
  echo "Fetching http://$HOST/eth/v2/beacon/blocks/$SLOT ..."
  wget -O signed-beacon-block.ssz -q --header='Accept: application/octet-stream' http://$HOST/eth/v2/beacon/blocks/$SLOT
  cd ..
  shift
  SLOT=$1
done 
