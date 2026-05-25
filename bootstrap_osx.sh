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
    aws-sam-cli
    aws-vault
    awscli
    bat
    colima
    docker
    docker-buildx
    docker-completion
    docker-compose
    eza
    fd
    fnm
    fzf
    gcc
    gh
    git
    gnupg
    gzip
    jira-cli
    jq
    lazydocker
    lazygit
    luarocks
    maccy
    mcfly
    neovim
    powerlevel10k
    ripgrep
    stow
    task
    taskwarrior-tui
    thefuck
    tig
    tlrc
    tmux
    unzip
    uv
    wget
    yawsso
)

echo "Installing packages..."
brew install --quiet "${PACKAGES[@]}"

CASKS=(
    appcleaner
    # Conflicts with work software manager which also manages Arc
    # arc
    fluor
    font-jetbrains-mono-nerd-font
    ghostty
    mongodb-compass
    obsidian
    spotify
)

echo "Installing cask apps..."
brew install --quiet --cask "${CASKS[@]}"

if [ ! -d "$(bat --config-dir)/themes/" ]; then
    echo "Getting bat themes"
    zsh ./bat/get_themes.sh
fi

if [ ! -d "$HOME/.tmux/plugins/tpm/" ]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "TPM installed. You must open tmux, source ~/.tmux.conf and then prefix+I to install plugins"
fi

echo "Installing dotfiles..."
zsh ~/.dotfiles/install.sh
