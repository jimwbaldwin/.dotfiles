set -euo pipefail

# X-Code must be installed to run this
# https://docs.brew.sh/Installation#macos-requirements
# xcode-select --install
#
# You must have also installed the CLI tools OSX update
#
if [ ! -d "$HOME/.oh-my-zsh/" ]; then
    echo "Installing OhMyZsh..."
    zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Check for Homebrew, install if not installed
if test ! "$(which brew)"; then
    echo "Installing homebrew..."
    zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew update
brew upgrade

TAPS=(
    ankitpokhrel/jira-cli
    cantino/mcfly
    romkatv/powerlevel10k
    systemmanic/yawsso
)
for tap in "${TAPS[@]}"; do
    if ! brew tap | grep -q "$tap"; then
        echo "Tapping $tap..."
        brew tap "$tap"
    fi
done

PACKAGES=(
    awscli
    bat
    colima
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
    jira-cli
    jq
    lazygit
    mcfly
    neovim
    powerlevel10k
    pyenv
    ripgrep
    task
    thefuck
    tlrc
    tig
    tmux
    unzip
    wget
    yawsso
)

echo "Installing packages..."
brew install --quiet "${PACKAGES[@]}"

CASKS=(
    alt-tab
    appcleaner
    arc
    fluor
    font-jetbrains-mono-nerd-font
    ghostty
    iterm2
    obsidian
    spotify
)

echo "Installing cask apps..."
brew install --quiet --cask "${CASKS[@]}"

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
