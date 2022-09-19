# Nix as a package manager
if [ -z $(command -v nix-env) ]; then
  curl -L https://nixos.org/nix/install | sh
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
else
  echo "Nix already installed: $(nix-env --version)"
fi

# While I'd like to be entirely using Nix, there is a large gap of supported
# packages for MacOS.
if [ -z $(command -v brew) ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed: $(brew --version)"
fi

nix-env -iA \
  nixpkgs.zsh \
  nixpkgs.zinit \
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

brew install --cask brave-browser

stow -d ./packages -t "${HOME}" git
stow -d ./packages -t "${HOME}" zsh
stow -d ./packages -t "${HOME}/.config" neovim

stow -d "$(nix-env -q --installed zinit --out-path --no-name)" -t "${HOME}/.local/share" share

# MacOS Applications
stow -d "$(nix-env -q --installed iterm2 --out-path --no-name)" -t /Applications Applications
stow -d "$(nix-env -q --installed alacritty --out-path --no-name)" -t /Applications Applications

command -v zsh | sudo tee -a /etc/shell  # Use zsh as login shell
sudo chsh -s "$(which zsh)" $USER        # Use zsh (installed by nix) as default shell

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
~/.local/share/nvim/site/pack/packer/start/cmp-tabnine/install.sh
