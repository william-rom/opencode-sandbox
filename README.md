This project builds a debian based apple container for running OpenCode in a more islolated environment.

## How to use
Build apple container with `build.sh`.

Example executable in `sboc`


## Security
Mounts only the workspace where container is run.
Persist build/dep caches and OpenCode data across runs in volumes seperate from host runs.

Should not be mounted in $HOME where a compromised agent could
modifiy runtime configuration files.

