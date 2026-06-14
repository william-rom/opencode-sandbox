ARG NODE_DIGEST
FROM node:22-slim@${NODE_DIGEST}

ENV CGO_ENABLED=0 \
    PATH=/usr/local/go/bin:/usr/local/bin:/home/node/go/bin:/home/node/.local/bin:/usr/bin:/bin

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates curl git ripgrep jq build-essential openssl \
 && rm -rf /var/lib/apt/lists/*

ARG GO_VERSION
ARG GO_SHA256
RUN curl -fsSLo /tmp/go.tgz "https://go.dev/dl/go${GO_VERSION}.linux-arm64.tar.gz" \
 && echo "${GO_SHA256}  /tmp/go.tgz" | sha256sum -c - \
 && tar -C /usr/local -xzf /tmp/go.tgz \
 && rm /tmp/go.tgz

ARG JUST_VERSION
ARG JUST_SHA256
RUN curl -fsSLo /tmp/just.tgz \
      "https://github.com/casey/just/releases/download/${JUST_VERSION}/just-${JUST_VERSION}-aarch64-unknown-linux-musl.tar.gz" \
 && echo "${JUST_SHA256}  /tmp/just.tgz" | sha256sum -c - \
 && tar -C /usr/local/bin -xzf /tmp/just.tgz just \
 && rm /tmp/just.tgz

ARG GH_VERSION
ARG GH_SHA256
RUN curl -fsSLo /tmp/gh.tgz \
      "https://github.com/cli/cli/releases/download/${GH_VERSION}/gh_${GH_VERSION#v}_linux_arm64.tar.gz" \
 && echo "${GH_SHA256}  /tmp/gh.tgz" | sha256sum -c - \
 && tar -C /usr/local/bin --strip-components=1 -xzf /tmp/gh.tgz \
        gh_${GH_VERSION#v}_linux_arm64/bin/gh \
 && rm /tmp/gh.tgz

ARG UV_VERSION
ARG UV_SHA256
RUN curl -fsSLo /tmp/uv.tgz \
      "https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-aarch64-unknown-linux-gnu.tar.gz" \
 && echo "${UV_SHA256}  /tmp/uv.tgz" | sha256sum -c - \
 && tar -C /usr/local/bin --strip-components=1 -xzf /tmp/uv.tgz \
        uv-aarch64-unknown-linux-gnu/uv uv-aarch64-unknown-linux-gnu/uvx \
 && rm /tmp/uv.tgz

ARG OPENCODE_VERSION
ARG OPENCODE_INTEGRITY
RUN npm pack "opencode-ai@${OPENCODE_VERSION}" --pack-destination=/tmp >/dev/null \
 && TARBALL="/tmp/opencode-ai-${OPENCODE_VERSION}.tgz" \
 && ACTUAL="sha512-$(openssl dgst -sha512 -binary "${TARBALL}" | base64 | tr -d '\n')" \
 && if [ "${ACTUAL}" != "${OPENCODE_INTEGRITY}" ]; then \
        echo "OpenCode integrity mismatch (expected ${OPENCODE_INTEGRITY}, got ${ACTUAL})" >&2; \
        exit 1; \
    fi \
 && npm install -g --omit=dev "${TARBALL}" \
 && rm "${TARBALL}" \
 && npm cache clean --force

ARG RUFF_VERSION
ARG RUFF_SHA256
RUN curl -fsSLo /tmp/ruff.tgz \
      "https://github.com/astral-sh/ruff/releases/download/${RUFF_VERSION}/ruff-aarch64-unknown-linux-gnu.tar.gz" \
  && echo "${RUFF_SHA256}  /tmp/ruff.tgz" | sha256sum -c - \
  && tar -C /usr/local/bin --strip-components=1 -xzf /tmp/ruff.tgz \
        ruff-aarch64-unknown-linux-gnu/ruff \
  && rm /tmp/ruff.tgz

USER node

ARG GOOSE_VERSION
ARG SQLC_VERSION
ARG SWAG_VERSION
RUN go install github.com/pressly/goose/v3/cmd/goose@${GOOSE_VERSION} \
 && go install github.com/sqlc-dev/sqlc/cmd/sqlc@${SQLC_VERSION} \
 && go install github.com/swaggo/swag/cmd/swag@${SWAG_VERSION} \
 && go clean -modcache

ARG PYTHON_VERSION
RUN uv python install ${PYTHON_VERSION}

ENTRYPOINT ["opencode"]
