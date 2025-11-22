#!/data/data/com.termux/files/usr/bin/bash
# Helper Function
ask() {
    local prompt="$1" default="$2" answer

    while true; do
        if [ "$default" = "y" ]; then
            echo -n "$prompt (Y/n): "
        else
            echo -n "$prompt (y/N): "
        fi
        read answer
        [ -z "$answer" ] && answer="$default"
        answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')
        case "$answer" in
            y | yes) return 0 ;;
            n | no) return 1 ;;
            *) echo "Invalid choice, try again." ;;
        esac
    done
}

choice() {
    local title="" outvar="choice_output" input
    local keys=() labels=()

    while (($#)); do
        case $1 in
            -t)  title=$2; shift 2;;
            -c)  keys+=("$2"); labels+=("$3"); shift 3;;
            -ov) outvar=$2; shift 2;;
            *) shift;;
        esac
    done

    [[ $title ]] && echo "$title"
    for i in "${!keys[@]}"; do
        printf "%s) %s\n" "${keys[i]}" "${labels[i]}"
    done

    while true; do
        read -rp "Select: " input
        input="${input//[[:space:]]/}"

        for i in "${!keys[@]}"; do
            [[ $input == "${keys[i]}" ]] && {
                printf -v "$outvar" %s "$input"
                return 0
            }
        done

        echo "Invalid choice."
    done
}

# Initial
echo "Termux Setup"
if ask "Hello $(whoami), Do you want to start setup" y; then
    if [ $(($(date +%s) - $(stat -c %Y $PREFIX))) -le 3600 ] || ask "It looks like your termux is not freshly installed (You can use termux-reset or go to app settings and clear data to reset your termux) or Do you want to continue anyway (may break your current setup)?" n; then
        cd "$HOME"
        pkg update -y
        pkg upgrade -y
        pkg install x11-repo root-repo -y
        apt autoclean -y
        apt autoremove -y
        termux-setup-storage

        # Configure Terminal Environment
        # if ask "Apply termux.properties custom configuration (Not implemented yet, Choices have no effect)" y; then
        # cat >"$HOME/.termux/termux.properties" <<'EOF'
        # EOF
        # fi

        if ask "Install and Apply JetBrainsMono Nerd Font Mono (Regular)" y; then
            pkg install curl -y
            rm -f "$HOME/.termux/font.ttf"
            curl -L -o "$HOME/.termux/font.ttf" \
                "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFontMono-Regular.ttf"
        fi

        if ask "Apply Tokyo Night colorscheme" y; then
            cat > "$HOME/.termux/colors.properties" << 'EOF'
# Tokyo Night color scheme
foreground=#a9b1d6
background=#1a1b26
cursor=#c0caf5

color0=#414868
color1=#f7768e
color2=#73daca
color3=#e0af68
color4=#7aa2f7
color5=#bb9af7
color6=#7dcfff
color7=#c0caf5

color8=#414868
color9=#f7768e
color10=#73daca
color11=#e0af68
color12=#7aa2f7
color13=#bb9af7
color14=#7dcfff
color15=#c0caf5
EOF
        fi

        if ask "Install Fastfetch with custom config" y; then
            pkg install fastfetch -y
            mkdir -p "$HOME/fastfetch"
            cat > "$HOME/fastfetch/config.jsonc" << 'EOF'
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "type": "builtin",
    "height": 15,
    "width": 30,
    "padding": {
      "top": 5,
      "left": 3
    }
  },
  "modules": [
    "break",
    { "type": "custom", "format": "\u001b[90m┌─ Hardware ───────────────────────────────────────────┐" },
    { "type": "host", "key": " PC", "keyColor": "green" },
    { "type": "cpu", "key": "│ ├", "keyColor": "green" },
    { "type": "gpu", "key": "│ ├󰍛", "keyColor": "green" },
    { "type": "memory", "key": "│ ├󰍛", "keyColor": "green" },
    { "type": "disk", "key": "└ └", "keyColor": "green" },
    { "type": "custom", "format": "\u001b[90m└─────────────────────────────────────────────────────┘" },
    "break",
    { "type": "custom", "format": "\u001b[90m┌─ Software ───────────────────────────────────────────┐" },
    { "type": "os", "key": " OS", "keyColor": "yellow" },
    { "type": "kernel", "key": "│ ├", "keyColor": "yellow" },
    { "type": "bios", "key": "│ ├", "keyColor": "yellow" },
    { "type": "packages", "key": "│ ├󰏖", "keyColor": "yellow" },
    { "type": "shell", "key": "└ └", "keyColor": "yellow" },
    "break",
    { "type": "de", "key": " DE", "keyColor": "blue" },
    { "type": "lm", "key": "│ ├", "keyColor": "blue" },
    { "type": "wm", "key": "│ ├", "keyColor": "blue" },
    { "type": "wmtheme", "key": "│ ├󰉼", "keyColor": "blue" },
    { "type": "terminal", "key": "└ └", "keyColor": "blue" },
    { "type": "custom", "format": "\u001b[90m└─────────────────────────────────────────────────────┘" },
    "break",
    { "type": "custom", "format": "\u001b[90m┌─ Uptime / Age / DT ─────────────────────────────────┐" },
    { "type": "command", "key": "  OS Age ", "keyColor": "magenta",
      "text": "birth=$(stat -c %W / 2>/dev/null || stat -f %c /); now=$(date +%s); days=$(( (now - birth) / 86400 )); printf '%d days' $days"
    },
    { "type": "uptime", "key": "  Uptime ", "keyColor": "magenta" },
    { "type": "datetime", "key": "  DateTime ", "keyColor": "magenta" },
    { "type": "custom", "format": "\u001b[90m└─────────────────────────────────────────────────────┘" },
    { "type": "colors", "paddingLeft": 2, "symbol": "circle" }
  ]
}
EOF

            # Ask run fastfetch
            if ask "Run fastfetch on start" n; then
                RUN_FASTFETCH=1
            else
                RUN_FASTFETCH=0
            fi

            # Ask for logo in fastfetch
            if ask "Add OS logo to fastfetch output" y; then
                FASTFETCH_LOGO=1
            else
                FASTFETCH_LOGO=0
            fi
        fi

        # Configure Desktop Environment
        XFCE_INSTALLED=0
        I3_INSTALLED=0
        if ask "Install desktop environment" n; then
            # DESKTOP ENVIRONMENT SELECTION
            choice -t "Select Desktop Environment:" -c 1 "XFCE (Fast)" -c 2 "i3 Window Manager (Customizable)" -c 0 "No Desktop Environment" -ov desk_choice

            # OPTION 1 — XFCE
            if [[ $desk_choice == "1" ]]; then
                XFCE_INSTALLED=1
                echo "Installing XFCE Desktop..."
                pkg install x11-repo tur-repo -y
                pkg install termux-x11-nightly xfce4 xfce4-goodies pulseaudio pavucontrol -y
                pkg install virglrenderer-android mesa-demos -y

                # Launcher
                cat > "$HOME/.termux/.startxfce4" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

killall -9 termux-wake-lock pulseaudio virgl_test_server_android $(pgrep -f "termux.x11")

pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1
pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1

virgl_test_server_android &

export XDG_RUNTIME_DIR=${TMPDIR}
export PULSE_SERVER=127.0.0.1

termux-x11 :0 &
sleep 3
am start -n com.termux.x11/com.termux.x11.MainActivity >/dev/null 2>&1
sleep 1

env DISPLAY=:0 dbus-launch --exit-with-session startxfce4 &
EOF
                chmod +x "$HOME/.termux/.startxfce4"
            fi

            # OPTION 2 — i3 WINDOW MANAGER
            if [[ $desk_choice == "2" ]]; then
                I3_INSTALLED=1
                echo "Installing i3 Window Manager..."

                pkg install x11-repo tur-repo -y
                pkg install termux-x11-nightly i3 i3status dmenu rofi feh pulseaudio pavucontrol -y
                pkg install virglrenderer-android mesa-demos -y

                # Launcher
                cat > "$HOME/.termux/.starti3" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

killall -9 termux-wake-lock pulseaudio virgl_test_server_android $(pgrep -f "termux.x11")

pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1
pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1

virgl_test_server_android &

export XDG_RUNTIME_DIR=${TMPDIR}
export PULSE_SERVER=127.0.0.1

termux-x11 :0 &
sleep 3
am start -n com.termux.x11/com.termux.x11.MainActivity >/dev/null 2>&1
sleep 1

env DISPLAY=:0 dbus-launch --exit-with-session i3 &
EOF
                chmod +x "$HOME/.termux/.starti3"

                # i3 config
                mkdir -p "$HOME/.config/i3"
                cat > "$HOME/.config/i3/config" << 'EOF'
# i3 CONFIG

font pango:JetBrainsMono Nerd Font 12

set $mod Mod4

bindsym $mod+Return exec xterm
bindsym $mod+Shift+q kill
bindsym $mod+d exec rofi -show drun
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'Exit i3?' -b 'Yes' 'i3-msg exit'"

set $ws1 "1"
set $ws2 "2"
set $ws3 "3"
set $ws4 "4"
set $ws5 "5"

bindsym $mod+1 workspace $ws1
bindsym $mod+2 workspace $ws2
bindsym $mod+3 workspace $ws3
bindsym $mod+4 workspace $ws4
bindsym $mod+5 workspace $ws5

bindsym $mod+Shift+1 move container to workspace $ws1
bindsym $mod+Shift+2 move container to workspace $ws2
bindsym $mod+Shift+3 move container to workspace $ws3
bindsym $mod+Shift+4 move container to workspace $ws4
bindsym $mod+Shift+5 move container to workspace $ws5

bindsym $mod+h split h
bindsym $mod+v split v
bindsym $mod+f fullscreen toggle

bindsym $mod+Shift+space floating toggle

bindsym $mod+j focus left
bindsym $mod+k focus down
bindsym $mod+l focus up
bindsym $mod+semicolon focus right

bindsym $mod+Shift+j move left
bindsym $mod+Shift+k move down
bindsym $mod+Shift+l move up
bindsym $mod+Shift+semicolon move right

mode "resize" {
    bindsym j resize shrink width 10 px or 10 ppt
    bindsym k resize grow height 10 px or 10 ppt
    bindsym l resize shrink height 10 px or 10 ppt
    bindsym semicolon resize grow width 10 px or 10 ppt

    bindsym Return mode "default"
    bindsym Escape mode "default"
}
bindsym $mod+r mode "resize"

bar {
    status_command i3status
}

exec --no-startup-id rofi -daemon
exec --no-startup-id feh
EOF
            fi

            # OPTION 0 — NO DESKTOP
            if [[ $desk_choice == "0" ]]; then
                echo "No Desktop Environment selected. Skipping..."
            fi

            if ask "Install FireFox" y; then
                pkg install firefox -y
            fi
            if ask "Install Code OSS" y; then
                pkg install code-oss -y
            fi

            # Optional font
            if ask "Add JetBrainsMono Nerd Font Mono (Regular) to Desktop Environment" y; then
                pkg install curl fontconfig -y
                mkdir -p "$PREFIX/share/fonts/TTF"
                rm -f "$PREFIX/share/fonts/TTF/JetBrainsMonoNerdFontMono-Regular.ttf"
                curl -L -o "$PREFIX/share/fonts/TTF/JetBrainsMonoNerdFontMono-Regular.ttf" \
                    "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFontMono-Regular.ttf"
                chmod 644 "$PREFIX/share/fonts/TTF/JetBrainsMonoNerdFontMono-Regular.ttf"
                fc-cache -fv
            fi

        fi

        # Make .bashrc
        if ask "Setup custom .bashrc" y; then
            cat > "$HOME/.bashrc" << EOF
# Cache cleanup
clear && echo "Loading..." && ( apt-get autoremove -y && apt-get autoclean -y ) >/dev/null 2>&1
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
$([ "${XFCE_INSTALLED:-0}" -eq 1 ] && echo "alias startxfce='sh \$HOME/.termux/.startxfce4'")
$([ "${XFCE_INSTALLED:-0}" -eq 1 ] && echo "alias sxfce='sh \$HOME/.termux/.startxfce4'")
$([ "${XFCE_INSTALLED:-0}" -eq 1 ] && echo "alias de='sh \$HOME/.termux/.startxfce4'")
$([ "${I3_INSTALLED:-0}" -eq 1 ] && echo "alias starti3='sh \$HOME/.termux/.starti3'")
$([ "${I3_INSTALLED:-0}" -eq 1 ] && echo "alias si3='sh \$HOME/.termux/.starti3'")
$([ "${I3_INSTALLED:-0}" -eq 1 ] && echo "alias de='sh \$HOME/.termux/.starti3'")
$([ "${FASTFETCH_LOGO:-0}" -eq 0 ] && echo "alias fastfetch='\$PREFIX/bin/fastfetch -l none'")
$([ "${RUN_FASTFETCH:-0}" -eq 1 ] && echo fastfetch)

# Custom PS1
PS1='[\u@\h \[\e[0;32m\]\w\[\e[0m\]] \[\e[0;97m\]\$\[\e[0m\] '
EOF
        fi
    fi
fi

# Finalizing
echo "Finalizing"
apt autoclean -y
apt autoremove -y
termux-reload-settings
clear
bash "$HOME/.bashrc"
exit 0
