#!/data/data/com.termux/files/usr/bin/bash

# Init
echo "Termux Setup (Basic)"
echo "Hello $(whoami), starting setup..."

cd "$HOME"
pkg update -y
pkg upgrade -y
pkg install x11-repo root-repo -y
apt autoclean -y
apt autoremove -y
termux-setup-storage

# Configure Terminal Environment
echo "Installing JetBrainsMono Nerd Font..."
pkg install curl -y
rm -f "$HOME/.termux/font.ttf"
curl -L -o "$HOME/.termux/font.ttf" "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFontMono-Regular.ttf"

# Make .bashrc
echo "Setting up custom .bashrc..."
cat >"$HOME/.bashrc" <<EOF
# Cache cleanup
clear && ( apt autoclean -y && apt autoremove -y ) >/dev/null 2>&1
clear

# Aliases
alias cp='cp -rv'
alias ls='ls --color=auto -ACF'
alias ll='ls -lhA'
alias mv='mv -v'
alias mkdir='mkdir -pv'
alias rf='rm -rf'
alias wget='wget -c'
alias fhere="find . -name "
alias ..='cd ..'
alias histg="history | grep"
EOF

# Finalizing
echo "Finalizing..."
clear
termux-reload-settings
bash "$HOME/.bashrc"
exit 0
