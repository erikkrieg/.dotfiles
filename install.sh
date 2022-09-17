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
  nixpkgs.delta \
  nixpkgs.gh \
  nixpkgs.fzf \
  nixpkgs.jq \
  nixpkgs.exa \
  nixpkgs.ripgrep \
  nixpkgs.alacritty \
  nixpkgs.iterm2

stow -d ./packages -t "${HOME}" git
stow -d ./packages -t "${HOME}" zsh
stow -d ./packages -t "${HOME}/.config" neovim

# MacOS Applications
stow -d "$(nix-env -q --installed iterm2 --out-path --no-name)" -t /Applications Applications
stow -d "$(nix-env -q --installed alacritty --out-path --no-name)" -t /Applications Applications

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
~/.local/share/nvim/site/pack/packer/start/cmp-tabnine/install.sh
