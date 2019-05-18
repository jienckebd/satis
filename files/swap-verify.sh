#!/usr/bin/env bash

if [[ ! -z ${SYS_SWAP_PATH+x} ]] && [[ ! -z ${SYS_SWAP_COUNT+x} ]]; then

  if [[ ! -f "${SYS_SWAP_PATH}" ]]; then
    cd /var
    touch "${SYS_SWAP_PATH}"
    chmod 600 "${SYS_SWAP_PATH}"
    dd if=/dev/zero of="${SYS_SWAP_PATH}" bs=1024k count="${SYS_SWAP_COUNT}"
    mkswap "${SYS_SWAP_PATH}"
    swapon "${SYS_SWAP_PATH}"
    echo "${SYS_SWAP_PATH}    none    swap    sw    0    0" >> /etc/fstab
  fi

fi
