# Termux Setup

Automated setup script that transforms [Termux](https://github.com/termux/termux-app) into a fully-featured development environment. Available in two versions: **Full** (complete desktop environment) and **Basic** (lightweight essentials).

## Features

### Basic Version (Lightweight)
- **JetBrains Mono Nerd Font**: Icon-enabled font
- **Enhanced Shell**: Custom `.bashrc` with productivity aliases
- **Automated Updates**: System package management

### Full Version (Complete)
- All Basic features plus:
- **Tokyo Night Theme**: Modern color scheme
- **Custom Fastfetch**: System information display
- **XFCE4 Desktop**: Complete desktop environment via Termux:X11
- **Hardware Acceleration**: Optimized graphics performance
- **Audio Support**: PulseAudio integration

## Installation

### Basic Version (Recommended for basic usage)
```bash
curl -fsSL https://raw.githubusercontent.com/ringgarevanka/termux-setup/refs/heads/main/setup_basic.sh -o setup_basic.sh && bash setup_basic.sh && rm setup_basic.sh
```

### Full Version (Includes desktop environment, Optional)
```bash
curl -fsSL https://raw.githubusercontent.com/ringgarevanka/termux-setup/refs/heads/main/setup.sh -o setup.sh && bash setup.sh && rm setup.sh
```

## Requirements

### Core Version
- [Termux app](https://github.com/termux/termux-app)
- Android 7.0+
- 2GB storage
- Stable internet connection

### Full Version
- [Termux app](https://github.com/termux/termux-app)
- Android 7.0+
- 4GB storage
- 6GB RAM recommended
- [Termux:X11](https://github.com/termux/termux-x11) app (for desktop)

## Desktop Usage (Full Version Only)

```bash
startxfce    # Launch XFCE4 desktop
```

**Note**: Requires Termux:X11 app installation.

## Shell Aliases (Both Versions)

```bash
ll='ls -lhA'           # Detailed listing
..='cd ..'             # Navigate up
fhere='find . -name'   # Quick search
histg='history | grep' # Search history
```

View all aliases: `alias`

## Troubleshooting

**Installation fails**: Check internet connection and storage space  
**Font not applied**: Restart Termux, verify `~/.termux/font.ttf` exists  
**Package errors**: Run `pkg update && pkg clean` then retry  
**Desktop issues** (Full only): Update Termux:X11, grant required permissions

## Configuration Files

### Core Version
- Font: `~/.termux/font.ttf`
- Shell: `~/.bashrc`

### Full Version (Additional)
- Colors: `~/.termux/colors.properties`
- Fastfetch: `~/fastfetch/config.jsonc`
- Desktop: `~/.termux/.startxfce4`

## Post-Installation

Restart Termux to apply all configurations. Verify font rendering and test aliases with `alias` command.

## Credits

This project uses the following components:

- **[Termux](https://github.com/termux/termux-app)** - Android terminal emulator
- **[Termux:X11](https://github.com/termux/termux-x11)** - X11 server implementation for Termux
- **[JetBrains Mono](https://github.com/JetBrains/JetBrainsMono)** - Nerd Font patched version
- **[Tokyo Night](https://github.com/tokyo-night/tokyo-night-vscode-theme)** - Color scheme
- **[Fastfetch](https://github.com/fastfetch-cli/fastfetch)** - System information tool
- **[XFCE](https://www.xfce.org/)** - Desktop environment
- **[PulseAudio](https://www.freedesktop.org/wiki/Software/PulseAudio/)** - Sound server

## Contributing

Issues and pull requests are welcome. Please include credits to this repository when using or modifying.

## Support

Report issues or request features at the [project repository](https://github.com/ringgarevanka/termux-setup).