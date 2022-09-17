# .dotfiles
Install and configure my development for MacOS.

## Quirks
Spotlight does not index nix store which prevents stowed applications from being discoverable with Spotlight. Can be patched by removing `nobrowse` from `/etc/fstab`. To do so, run `sudo vifs` to open a `vi` editor safely on the `fstab` file and make that change.

## Todos:
- clean up cmp-tabnine install?
- how can initial gitub auth setup be improved?
- add checks for emails and potential secrets as pre-commit hook.
- investigate Nix home-manager (`nix-env -iA nixpkgs.home-manager`).
- how should guis be added to Applications so that Spotlight indexes them? Is removing `nobrowse` from fstab a suitable option? Can the be changed at install?
