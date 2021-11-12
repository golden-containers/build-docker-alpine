#!/bin/bash

set -Eeuxo pipefail
rm -rf working
mkdir working
cd working

GCI_URL="ghcr.io/golden-containers"

# Checkout upstream

git clone --depth 1 --branch v3.14 --filter=blob:none --sparse https://github.com/alpinelinux/docker-alpine.git
cd docker-alpine
git sparse-checkout init --cone
git sparse-checkout set x86_64

# Transform

GCI_REGEX_URL=$(echo ${GCI_URL} | sed 's/\//\\\//g')

# This sed syntax is GNU sed specific
# [ -z $(command -v gsed) ] && GNU_SED=sed || GNU_SED=gsed

# Build

[ -z "${1:-}" ] && BUILD_LABEL_ARG="" || BUILD_LABEL_ARG=" --label \"${1}\" "

BUILD_PLATFORM=" --platform linux/amd64 "
BUILD_ARGS=" ${BUILD_LABEL_ARG} ${BUILD_PLATFORM} "

docker build x86_64/ ${BUILD_ARGS} \
    --tag ${GCI_URL}/alpine:latest \
    --tag ${GCI_URL}/alpine:3.14 
    
# Push

docker push ${GCI_URL}/alpine -a
