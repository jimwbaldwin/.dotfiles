#! /bin/bash
set -euo pipefail

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install build-essential zlib1g-dev libffi-dev libssl-dev libbz2-dev libreadline-dev libsqlite3-dev liblzma-dev

if test ! "$(which zsh)"; then
    echo "Installing zsh..."
    brew install zsh
fi

if [ ! -d "$HOME/.oh-my-zsh/" ]; then
    echo "Installing OhMyZsh..."
    zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Check for Homebrew, install if not installed
if test ! "$(which brew)"; then
    echo "Installing homebrew..."
    zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if test ! "$(which pyenv)"; then
    echo "Installing pyenv..."
    curl https://pyenv.run | bash
fi

brew update
brew upgrade

PACKAGES=(
    bat
    docker
    docker-buildx
    docker-completion
    eza
    fd
    fzf
    gcc
    gh
    git
    gnupg
    gzip
    jq
    lazygit
    mcfly
    neovim
    openssl
    powerlevel10k
    ripgrep
    thefuck
    tlrc
    tig
    tmux
    unzip
    wget
)

echo "Installing packages..."
brew install --quiet "${PACKAGES[@]}"

if test ! :"$(which poetry)"; then
    echo "Installing poetry..."
    curl -sSL https://install.python-poetry.org | python3 -
fi

if [ ! -d "$(bat --config-dir)/themes/" ]; then
    echo "Getting bat themes"
    zsh ./bat/get_themes.sh
fi

if [ ! -d "$HOME/.tmux/plugins/tpm/" ]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "TPM installed. You must open tmux, source ~/.tmux.conf and then prefix+I to install plugins"
fi

zsh ~/.dotfiles/install.sh
