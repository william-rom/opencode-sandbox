#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

# === Pinned values. Refresh via the lookup commands documented below. ===
# Last refreshed: 2026-05-16
NODE_DIGEST="sha256:689c11043dad91472750cd824c97dd5e2318e9dd6f954e492fe7af0135d33ceb"
GO_VERSION="1.26.3"
GO_SHA256="9d89a3ea57d141c2b22d70083f2c8459ba3890f2d9e818e7e933b75614936565"
UV_VERSION="0.11.14"
UV_SHA256="c4958f729e216f1610632574ed927b8cf0af1bd02cb88cb30d948571727aee43"
JUST_VERSION="1.51.0"
JUST_SHA256="ed7ec466b77709198fd4afed253dba0270203ba5eb1c006bee2b0139090284f5"
PYTHON_VERSION="3.11.15"
GOOSE_VERSION="v3.27.1"
SQLC_VERSION="v1.31.1"
SWAG_VERSION="v1.16.6"
OPENCODE_VERSION="1.15.3"
OPENCODE_INTEGRITY="sha512-nQQfqqRqDo4NIvc4wwLd7+jvKStlbPal6HuuJMbkpLlW6nOraI4z506+unWtP4L3KDh6mIGXTlaFCjAyiBFZlA=="
# ========================================================================

exec container build \
  --build-arg NODE_DIGEST="${NODE_DIGEST}" \
  --build-arg GO_VERSION="${GO_VERSION}" \
  --build-arg GO_SHA256="${GO_SHA256}" \
  --build-arg JUST_VERSION="${JUST_VERSION}" \
  --build-arg JUST_SHA256="${JUST_SHA256}" \
  --build-arg UV_VERSION="${UV_VERSION}" \
  --build-arg UV_SHA256="${UV_SHA256}" \
  --build-arg PYTHON_VERSION="${PYTHON_VERSION}" \
  --build-arg GOOSE_VERSION="${GOOSE_VERSION}" \
  --build-arg SQLC_VERSION="${SQLC_VERSION}" \
  --build-arg SWAG_VERSION="${SWAG_VERSION}" \
  --build-arg OPENCODE_VERSION="${OPENCODE_VERSION}" \
  --build-arg OPENCODE_INTEGRITY="${OPENCODE_INTEGRITY}" \
  -t opencode-sandbox:latest .
