# Nix as a package manager
if [ -z $(command -v nix-env) ]; then
  curl -L https://nixos.org/nix/install | sh
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
else
  echo "Nix already installed: $(nix-env --version)"
fi

nix-env -iA \
  nixpkgs.zsh \
  nixpkgs.git \
  nixpkgs.gum \
  nixpkgs.stow \
  nixpkgs.neovim \
  nixpkgs.bat \
  nixpkgs.delta

stow -d ./packages -t "${HOME}" git

