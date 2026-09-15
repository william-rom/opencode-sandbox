#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

# Pinned values. Last refreshed: 2026-09-15
NODE_DIGEST="sha256:83f487e0a63425e5b4d146fb5e5be574bcbe1b7b843d3ebafdd95eaf7767a7e5"
GO_VERSION="1.27.1"
GO_SHA256="3450b45a3f9ee8568792736a5c5e70a1f2e9b36c35a8f74958c03e51d7d92bec"
UV_VERSION="0.12.14"
UV_SHA256="7fb91bd5d10529c60723eaec3caf44726f89280e5aeed78af8fc63fcad004c9b"
JUST_VERSION="1.58.0"
JUST_SHA256="748237128c4c40cbdabc65e841d05ceba13cc23a91eaba395495894c1d9764df"
GH_VERSION="v2.100.0"
GH_SHA256="ea4e7a581a32ccad6cc7923cb1576ac5859ba4b9a16ab22eb8f8a96e78e2e961"
PYTHON_VERSION="3.11.16"
RUFF_VERSION="0.16.7"
RUFF_SHA256="1e06b11127c28387c8066da4ce6a617a84a359591be09dbf581fbb0c3e006239"
GOOSE_VERSION="v3.28.0"
SQLC_VERSION="v1.31.1"
SWAG_VERSION="v1.16.6"
OPENCODE_VERSION="1.18.31"
OPENCODE_INTEGRITY="sha512-J95feefeWwtIaw3irx76WjzWcgQXxmuHmDVphvs5ep9X30fBJ6T6bFhw50i9Kx50MG/xPn5w2pafXIfNtdry9w=="

exec container build \
  --no-cache \
  --build-arg NODE_DIGEST="${NODE_DIGEST}" \
  --build-arg GO_VERSION="${GO_VERSION}" \
  --build-arg GO_SHA256="${GO_SHA256}" \
  --build-arg JUST_VERSION="${JUST_VERSION}" \
  --build-arg JUST_SHA256="${JUST_SHA256}" \
  --build-arg GH_VERSION="${GH_VERSION}" \
  --build-arg GH_SHA256="${GH_SHA256}" \
  --build-arg UV_VERSION="${UV_VERSION}" \
  --build-arg UV_SHA256="${UV_SHA256}" \
  --build-arg PYTHON_VERSION="${PYTHON_VERSION}" \
  --build-arg RUFF_VERSION="${RUFF_VERSION}" \
  --build-arg RUFF_SHA256="${RUFF_SHA256}" \
  --build-arg GOOSE_VERSION="${GOOSE_VERSION}" \
  --build-arg SQLC_VERSION="${SQLC_VERSION}" \
  --build-arg SWAG_VERSION="${SWAG_VERSION}" \
  --build-arg OPENCODE_VERSION="${OPENCODE_VERSION}" \
  --build-arg OPENCODE_INTEGRITY="${OPENCODE_INTEGRITY}" \
  -t opencode-sandbox:latest .
