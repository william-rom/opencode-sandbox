## How to ugprade dependencies
Use only read-only tools so the upgrade agent can run unattended: `WebFetch` (read-only HTTP GET,
allowlist by domain) and read-only `gh release view` / `gh release list`. Do NOT use `curl`,
`gh release download`, `gh api`, or curl-piped-bash — those write files or hit arbitrary endpoints
and require manual inspection. Wrong values fail the build at `sha256sum -c` / the integrity check,
so they cannot slip through silently.

For `WebFetch`, ask for the raw/verbatim value in the prompt. GitHub release-asset URLs return a
cross-host redirect to `release-assets.githubusercontent.com`; call `WebFetch` again on the redirect
URL it hands back (both hosts are read-only GETs).

NODE_DIGEST       — WebFetch https://hub.docker.com/v2/repositories/library/node/tags/22-slim
                      → exact "digest" field (sha256:...)
GO_VERSION,SHA    — WebFetch https://go.dev/dl/?mode=json
                      → first entry "version"; sha256 of file where os=linux, arch=arm64, kind=archive
UV_VERSION        — gh release view --repo astral-sh/uv --json tagName --jq .tagName
UV_SHA256         — WebFetch https://github.com/astral-sh/uv/releases/download/<ver>/uv-aarch64-unknown-linux-gnu.tar.gz.sha256
                      (follow redirect) → first field = hash
JUST_VERSION      — gh release view --repo casey/just --json tagName --jq .tagName
JUST_SHA256       — WebFetch https://github.com/casey/just/releases/download/<ver>/SHA256SUMS
                      (follow redirect) → hash on the line for just-<ver>-aarch64-unknown-linux-musl.tar.gz
GH_VERSION        — gh release view --repo cli/cli --json tagName --jq .tagName
GH_SHA256         — WebFetch https://github.com/cli/cli/releases/download/<ver>/gh_<ver-without-v>_checksums.txt
                      (follow redirect) → hash on the line for gh_<ver-without-v>_linux_arm64.tar.gz
RUFF_VERSION      — gh release view --repo astral-sh/ruff --json tagName --jq .tagName
RUFF_SHA256       — WebFetch https://github.com/astral-sh/ruff/releases/download/<ver>/ruff-aarch64-unknown-linux-gnu.tar.gz.sha256
                      (follow redirect) → first field = hash
PYTHON_VERSION    — WebFetch https://www.python.org/downloads/ → latest 3.11.x (must be supported by python-build-standalone)
GOOSE_VERSION     — gh release view --repo pressly/goose --json tagName --jq .tagName
SQLC_VERSION      — gh release view --repo sqlc-dev/sqlc  --json tagName --jq .tagName
SWAG_VERSION      — gh release list --repo swaggo/swag --exclude-pre-releases --limit 1 (skip v2.x RCs)
OPENCODE_VERSION  — WebFetch https://registry.npmjs.org/opencode-ai/latest → "version" (must be >= 1.1.10)
OPENCODE_INTEGRITY— WebFetch https://registry.npmjs.org/opencode-ai/latest → "dist.integrity" (same fetch as above)

