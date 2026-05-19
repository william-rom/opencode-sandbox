# OpenCode Sandbox Container 
This project builds a debian based apple container for running OpenCode in a more islolated environment.

## How to use
1. Set up [Container](https://github.com/apple/container) on your mac.

2. Build the apple container with `build.sh`.

3. Example executable in `sboc` runs the container.
Should not be ran in $HOME as that removes the security gains we get 
from the mounting strategy.


## Security
By default, coding agents acts on behelf of the user on the users machine. 
This is a powerful model, but creates a large attack surface.


**The agent does not has full filesystem access**
This container bind-mounts only the current directory.
This leaves directories like `-/.ssh`, the macOS keychain, $HOME and runtime configuration files un-reachable to the agent.

**OpenCode config can not be edited**
We mount the opencode config read-only.
This stops a compromised agent from redirecting future sessions to attacker controlled 
endpoints, changing default permissions or wiring malicious MCPs.

**Dependencies are cached separate of host dependencies**
Dependency and build cache is persisted across containers for speed,
but is stored separate from host caches. Can be disabled as described in `sboc`.



