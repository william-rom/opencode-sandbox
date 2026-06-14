# OpenCode Sandbox Container 
This project builds a debian based Apple Container for running OpenCode
in a more isolated environment.

## Summary
Running coding agents on your machine comes with a large attack surface. 
A CVE in the agent, a malicious dependency, or a prompt-injected file all map
directly to your host.
This project narrows that attack surface by running OpenCode in a lightweight
Apple Container VM with a toolchain pre-installed for the technologies I work with.

## How to use
1. Set up [Container](https://github.com/apple/container) on your mac.

2. Customize the toolchain to your use.

3. Build the container with `build.sh`. 

4. Start the Container system service 
```sh
container system start
```

5. Run the container in your directory of choice. Example executable in `sboc`.

## Security
By default, coding agents act on behalf of the user on the user's machine. 
This is a powerful model, but creates a large attack surface. This repo showcases 
a few actions taken to protect host credentials and filesystem from common attack vectors.


### The agent does not have full filesystem access

This container bind-mounts only the current directory.
This leaves directories like `~/.ssh`, the macOS keychain, $HOME and runtime configuration files un-reachable to the agent.

### OpenCode config can not be edited

We mount the opencode config read-only.
This stops a compromised agent from redirecting future sessions to attacker controlled 
endpoints, changing default permissions or wiring malicious MCPs.

### Dependencies are cached separately from host dependencies

Dependency and build cache is persisted across containers for speed,
but is stored separate from host caches. Can be disabled as described in `sboc`.

### External dependencies are SHA pinned

This reduces the supply chain risk during image build.

## Github CLI
The container persists it gh cli token.
