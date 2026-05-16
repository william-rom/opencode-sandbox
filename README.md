This project builds a debian based apple container for running OpenCode.


## Security
Mounts only the workspace where container is run.
Persist build/dep caches and OpenCode data across runs in volumes seperate from host runs.

Should not be mounted in $HOME where a compromised agent could
modifiy runtime configuration files.

