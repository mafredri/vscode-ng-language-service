#!/usr/bin/env bash

set -ex -o pipefail

# Setup the environment
cd $(dirname $0)
source ./env.sh
cd ../..

# Build the server
(
  cd server
  yarn run compile
)

# Build the client
(
  cd client
  $(yarn bin)/tsc
)

# Install server production dependencies
(
  cd client/server
  yarn install --production
)

# Build the .vsix file
(
  rm -rf dist && mkdir dist
  cd client

  vsce package --out ../dist/ngls.vsix
)
