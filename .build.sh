#!/bin/bash
# .build.sh -- Script to build dist.tar.gz that should be run using Docker
# WARNING: This script makes changes to /etc/passwd and /etc/group, under
#          no circumstances should this be run outside of a Docker
#          container, as it may result in severe unpleasantness for users
#          of the system.

set -ex

# Determine the running user and group
SELF_UID=$(stat -c '%u' $0)
SELF_GID=$(stat -c '%g' $0)

# Create the user and group
addgroup --gid $SELF_GID builder
adduser --ingroup builder --disabled-password --gecos "BUILD USER" --uid $SELF_UID builder

# Prepare the local build environment
cd $(dirname $0)
sudo -u builder -H npm install
export PATH="${PWD}/node_modules/.bin:${PATH}"
sudo -u builder -H /usr/bin/env PATH="$PATH" bower install --config.interactive=false

# Build
sudo -u builder -H /usr/bin/env PATH="$PATH" grunt
