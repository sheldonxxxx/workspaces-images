#!/usr/bin/env bash
set -ex

# Install Signal
ARCH=$(arch | sed 's/aarch64/arm64/g' | sed 's/x86_64/amd64/g')
if [ "${ARCH}" == "arm64" ] ; then
    echo "Appflowy for arm64 currently not supported, skipping install"
    exit 0
fi

APPFLOWY_VERSION="0.9.3"

cd /tmp
wget -q -O AppFlowy-0.9.3-linux-x86_64.tar.gz "https://github.com/AppFlowy-IO/AppFlowy/releases/download/${APPFLOWY_VERSION}/AppFlowy-${APPFLOWY_VERSION}-linux-x86_64.tar.gz"
tar -xzf AppFlowy-0.9.3-linux-x86_64.tar.gz -C /opt

# Cleanup for app layer
chown -R 1000:0 $HOME
find /usr/share/ -name "icon-theme.cache" -exec rm -f {} \;
if [ -z ${SKIP_CLEAN+x} ]; then
  apt-get autoclean
  rm -rf \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*
fi
