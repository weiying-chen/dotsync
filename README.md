# sync

Barebones shell sync repo.

## Source of truth
- `bin/` -> deploys to `~/.local/bin/`
- `.bash_aliases` -> deploys to `~/.bash_aliases`

## Deploy
```sh
~/shell/sync/sync.sh
```

Then reload your shell:
```sh
reloadsh
```
