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
sudo -u builder -H bower install --allow-root --config.interactive=false

# Build
sudo -u builder -H grunt

# Prepare a tarball (n.b. if this file is in the root of the volume, tar,
# for some reason, hits a 'permission denied' error if it tries to create
# a tarball directly inside that directory, so we prepare the tarball in
# /tmp and move it over with root permissions)
sudo -u builder -H tar -czvf /tmp/dist.tar.gz dist/
mv /tmp/dist.tar.gz $(dirname $0)
