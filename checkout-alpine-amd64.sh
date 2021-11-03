#!/bin/sh

set -e

rm -rf docker-alpine
git clone --depth 1 --branch v3.14 --filter=blob:none --sparse https://github.com/alpinelinux/docker-alpine.git
cd docker-alpine
git sparse-checkout init --cone
git sparse-checkout set x86_64

