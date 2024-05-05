set -euo pipefail

# X-Code must be installed to run this
# https://docs.brew.sh/Installation#macos-requirements
# xcode-select --install
#
# You must have also installed the CLI tools OSX update
#
if [ ! -d "$HOME/.oh-my-zsh/" ]; then
    zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Check for Homebrew, install if not installed
if test ! $(which brew); then
    echo "Installing homebrew..."
    zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew update
brew upgrade

PACKAGES=(
    alfred
    awscli
    colima
    docker
    docker-buildx
    docker-completion
    gcc
    gh
    git
    gnupg
    gzip
    jq
    mcfly
    neovim
    pyenv
    ripgrep
    tig
    tmux
    unzip
    yawsso
)

echo "Installing packages..."
brew install --quiet ${PACKAGES[@]}


CASKS=(
    alfred
    alt-tab
    appcleaner
    arc
    fluor
    font-jetbrains-mono-nerd-font
    iterm2
    obsidian
    spotify
)

echo "Installing cask apps..."
brew install --quiet --cask ${CASKS[@]}

# Check for Poetry, install if not installed
if test ! $(which brew); then
    echo "Installing pyenv..."
    curl -sSL https://install.python-poetry.org | python3 -
fi

zsh ~/.dotfiles/install.sh

