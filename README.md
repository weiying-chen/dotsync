# dotsync

Barebones shell sync repo.

## Source of truth
- `bin/` -> symlinks that deploy to `~/.local/bin/`
- `.bash_aliases` -> deploys to `~/.bash_aliases`
- `tmux/tmux.conf` -> deploys to `~/.tmux.conf`

`bin/dotsync` is a symlink to `dotsync.sh`, so the installed `dotsync` command always runs the repo copy.

## Deploy
```sh
~/shell/dotsync/dotsync.sh
```

Or use the deployed command:
```sh
dotsync
reloadsh
```
