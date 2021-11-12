#!/bin/bash

set -Eeuxo pipefail
rm -rf working
mkdir working
cd working

# Checkout upstream

git clone --depth 1 --branch v3.14 --filter=blob:none --sparse https://github.com/alpinelinux/docker-alpine.git
cd docker-alpine
git sparse-checkout init --cone
git sparse-checkout set x86_64

# Transform

# Build

docker build x86_64/ --tag ghcr.io/golden-containers/alpine:latest --tag ghcr.io/golden-containers/alpine:3.14 --label ${1:-DEBUG=TRUE}

# Push

docker push ghcr.io/golden-containers/alpine -a
