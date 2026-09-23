# OpenCode Sandbox Container 
This project builds a debian based Apple Container for running OpenCode
in a more isolated environment. 

## Summary
Running coding agents on your machine comes with a large attack surface. 
A CVE in the agent, a malicious dependency, or a prompt-injected file all map
directly to your host.
This project narrows that attack surface by running OpenCode in a lightweight
Apple Container VM with a toolchain pre-installed for the technologies I work with.

**Note:** this setup is in no way fool-proof, but gives a look into how agents
can be run more securely in a locked down environment.


## How to use
1. Set up [Container](https://github.com/apple/container) on your mac.

2. Customize the toolchain to your use. For ease of upgrades, create istructions for tool upgrades in AGENTS.md.

3. Start the Container system service 
```sh
container system start
```

4. Build the container with `build.sh`. 

5. Set up your sandbox config. (see sandbox-specific config section)

6. Add the run container script to path. E.g.
```sh
ln -s "$PWD/sboc" ~/.local/bin/sboc.
```

6. Run the container in your directory of choice. 

## Security
By default, coding agents act on behalf of the user on the user's machine. 
This is a powerful model, but creates a large attack surface. This repo showcases 
a few actions taken to protect host credentials and filesystem from common attack vectors.


### The agent does not have full filesystem access

This container bind-mounts only the current directory and a select set of caches and data.
This leaves directories like `~/.ssh`, the macOS keychain, $HOME and runtime configuration files unreachable to the agent.

Note: opencode's own auth is reachable in the container.

### Sandbox-specific config

The sandbox reads its config from `~/.config/sboc/opencode.json` on the host — a
dedicated file, not the host's own `~/.opencode`. Even though the agent runs in a 
sandbox, some things should in most cases be disallowed. E.g. deny read on .env.
(however, it should not be treated as safe. Many tools can be used to get contents from a file!)

This command should be run on your host, and copies your default config to a new sandbox config folder.

```sh
mkdir -p ~/.config/sboc && cp ~/.config/opencode/opencode.json ~/.config/sboc/
```

It is mounted read-only at `/home/node/.opencode`. This stops a compromised agent
from editing the global config, changing default
permissions or wiring malicious MCPs (local config can still be edited!).

### Dependencies are cached separately from host dependencies

Dependency and build cache is persisted across containers for speed,
but is stored separate from host caches. Can be disabled as described in `sboc`.

### External dependencies are checksum-verifed.

This reduces the supply chain risk during image build.

## Github CLI
The container persists its gh cli token.
This should be a fine-grained or read-only token based on needs.
