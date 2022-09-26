#!/bin/sh

# Nix as a package manager
if [ -z "$(command -v nix-env)" ]; then
  curl -L https://nixos.org/nix/install | sh
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
else
  echo "Nix already installed: $(nix-env --version)"
fi

# While I'd like to be entirely using Nix, there is a large gap of supported
# packages for MacOS.
if [ -z "$(command -v brew)" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed: $(brew --version)"
fi

NIX_PROFILE_BIN="${HOME}/.nix-profile/bin"
nix-env -f '<nixpkgs>' -iA \
  zsh \
  zinit \
  git \
  gum \
  stow \
  neovim \
  bat \
  delta \
  gh \
  fzf \
  jq \
  exa \
  ripgrep \
  alacritty \
  iterm2 \
  direnv \
  nix-direnv \
  dash \
  nodePackages.bash-language-server \
  shellcheck

brew install --cask brave-browser
brew install --cask spotify
brew install --cask discord

# Trying different ways of stowing because I'm not sure what my preference is yet.
stow -d ./packages -t "${HOME}" direnv
stow -d ./packages -t "${HOME}" git
stow -d ./packages -t "${HOME}" zsh
stow -d ./packages -t "${HOME}/.config" neovim
stow -d ./packages -t "${HOME}" alacritty

stow -d "$(nix-env -q --installed zinit --out-path --no-name)" -t "${HOME}/.local/share" share

# MacOS Applications
stow -d "$(nix-env -q --installed iterm2 --out-path --no-name)" -t /Applications Applications
stow -d "$(nix-env -q --installed alacritty --out-path --no-name)" -t /Applications Applications

# Set zsh as the default shell
ZSH="${NIX_PROFILE_BIN}/zsh"
if [ "${SHELL}" != "${ZSH}" ]; then
  command -v zsh | sudo tee -a /etc/shell   # Use zsh as login shell
  sudo chsh -s "${ZSH}" "${USER}"           # Use zsh (installed by nix) as default shell
fi

# Set sh to execute dash because it is faster than bash
# Important: dash doesn't support parts of bash because it isn't a superset of posix
DASH="${NIX_PROFILE_BIN}/dash"
if [ "$(readlink /var/select/sh)" != "${DASH}" ]; then
  sudo ln -sf "${DASH}" /var/select/sh
fi

# Install or sync neovim plugins
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
~/.local/share/nvim/site/pack/packer/start/cmp-tabnine/install.sh

# Disables login log from new shell instances.
touch ~/.hushlogin
