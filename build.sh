#!/bin/bash
set -ex

npm install
bower install --config.interactive=false
grunt
