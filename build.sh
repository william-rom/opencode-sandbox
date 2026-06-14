#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

# Pinned values. Last refreshed: 2026-06-14
NODE_DIGEST="sha256:e21fc383b50d5347dc7a9f1cae45b8f4e2f0d39f7ade28e4eef7d2934522b752"
GO_VERSION="1.26.4"
GO_SHA256="ef758ae7c6cf9267c9c0ef080b8965f453d89ab2d25d9eb22de4405925238768"
UV_VERSION="0.11.21"
UV_SHA256="88e800834007cc5efd4675f166eb2a51e7e3ad19876d85fa8805a6fb5c922397"
JUST_VERSION="1.52.0"
JUST_SHA256="41af45372c49c404ca7b9a318ae9de5564636e39c6520cc4d42bf678f3bfb1bc"
GH_VERSION="v2.94.0"
GH_SHA256="705a23b70b0f1b7ba4c302fdcef392ce3edaacfa7ce8e85e4d93d72ea800a538"
PYTHON_VERSION="3.11.15"
RUFF_VERSION="0.15.17"
RUFF_SHA256="71593a6ca85cfede1743b9163aa4531a273f0eed6ae6c99d26ffe2af51bb5a3d"
GOOSE_VERSION="v3.27.1"
SQLC_VERSION="v1.31.1"
SWAG_VERSION="v1.16.6"
OPENCODE_VERSION="1.17.6"
OPENCODE_INTEGRITY="sha512-pJpt21bapyvQ5Mye0M0IY3VGGDF48ddRdV7goyEVuNTtGo1OFmyuMCFsWX4ALbj8bHf+ebwTtVtCa2fwoI+uEQ=="

exec container build \
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
