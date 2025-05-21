#!/bin/bash

# Get amount
device_count=$(rtl_biast -d 0 2>&1 | grep -a "Found [0-9]\+ device(s):" | awk '{print $2}')

# Check amount
if [ -z "$device_count" ]; then
  echo "RTL-SDR device not found, please check" >&2
  exit 1
elif [ "$device_count" -gt 1 ]; then
  echo "${device_count} Devices detected, please remove $((device_count - 1)) of them" >&2
  exit 2
fi

# Get tuner
tuner_model=$(rtl_biast -d 0 2>&1 | grep -a "Found.*tuner" | sed -n 's/.*Found \(.*\) tuner.*/\1/p')

# Check result
if [ -z "$tuner_model" ]; then
  echo "Tuner model not found" >&2
  exit 3
else
  echo "$tuner_model"
  exit 0
fi
