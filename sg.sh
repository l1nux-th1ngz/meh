#!/bin/bash

# Check if the system supports SGX
if [ ! -e "/dev/isgx" ]; then
  echo "SGX is not supported on this system."
  exit 1
fi

# Check if SGX is enabled
if [ -e "/sys/devices/virtual/misc/sgx/enclave" ]; then
  echo "SGX is already enabled on this system."
  exit 0
fi

# Check if SGX is disabled by BIOS
if [ -e "/sys/devices/virtual/misc/sgx/status" ]; then
  SGX_STATUS=$(cat /sys/devices/virtual/misc/sgx/status)
  if [ "$SGX_STATUS" == "disabled" ]; then
    echo "SGX is currently disabled in the BIOS."
    echo "You need to enable it manually in your system's BIOS/UEFI settings."
    echo "The process to enable SGX in BIOS varies by motherboard manufacturer and model. Consult your motherboard's manual for instructions."
    exit 1
  fi
fi

# If SGX is in an unknown state
echo "SGX is in an unknown state on this system. Please check your system's BIOS/UEFI settings for SGX configuration."
exit 1
